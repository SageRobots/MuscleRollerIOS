//
//  Bluetooth.swift
//  MuscleRoller
//
//  Created by Carl Winge on 8/17/22.
//

import Foundation
import CoreBluetooth

class BT: NSObject, ObservableObject {
    let BLEService_UUID = CBUUID(string: "00FF")
    var connectedService: CBService?
    let charUuid = [CBUUID(string: "FF01"), CBUUID(string: "FF02")]
    var char = [CBCharacteristic?](repeating: nil, count: 2)
    private var centralManager: CBCentralManager!
    @Published var espPeripheral: CBPeripheral!
    @Published var peripheralArray: [CBPeripheral] = []
    @Published var disableScan = false
    var timer = Timer()
    
    struct Motor {
        var home = false
        var homed = false
        var position = 0
        var target = 0
        var speed = 0.0
        var force = 0.0
        var targetForce = 0.0
    }
    @Published var motorX = Motor()
    @Published var motorZ = Motor()
    
    override init() {
        super.init()
        // Manager
        centralManager = CBCentralManager(delegate: self, queue: nil)
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            self.read()
        })
    }
    
    func startScanning() -> Void {
        print("scanning")
        // Remove prior data
        peripheralArray.removeAll()
        disconnectFromDevice()
        // Start Scanning
        centralManager?.scanForPeripherals(withServices: [BLEService_UUID])
        disableScan = true
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) {_ in
            self.stopScanning()
        }
    }
    
    func stopScanning() -> Void {
        print("stopping")
        disableScan = false
        centralManager?.stopScan()
    }
    
    func connectToDevice() -> Void {
        centralManager?.connect(espPeripheral!, options: nil)
    }
    
    func disconnectFromDevice() -> Void {
        if espPeripheral != nil {
          centralManager?.cancelPeripheralConnection(espPeripheral!)
        }
    }
    
    func write(type: String, value: String) -> Void {
        var str = type
        str += ","
        str += value
        espPeripheral.writeValue(Data(str.utf8), for: char[0]!, type: CBCharacteristicWriteType.withResponse)
    }
    
    func cycle(startX: String, endX: String, startZ: String, force: String, travelSpeed: String, speed: String) -> Void {
        var str = "cycl,"
        str += startX
        str += ","
        str += endX
        str += ","
        str += startZ
        str += ","
        str += force
        str += ","
        str += travelSpeed
        str += ","
        str += speed

        espPeripheral.writeValue(Data(str.utf8), for: char[0]!, type: CBCharacteristicWriteType.withResponse)
    }
    
    func read() -> Void {
        if char[1] != nil {
            espPeripheral.readValue(for: char[1]!)
        }
    }
}

extension BT: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {

      switch central.state {
        case .poweredOff:
            print("Is Powered Off.")
        case .poweredOn:
            print("Is Powered On.")
            startScanning()
        case .unsupported:
            print("Is Unsupported.")
        case .unauthorized:
        print("Is Unauthorized.")
        case .unknown:
            print("Unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
          print("Error")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
      print("Function: \(#function),Line: \(#line)")

      espPeripheral = peripheral

      if peripheralArray.contains(peripheral) {
          print("Duplicate Found.")
      } else {
        peripheralArray.append(peripheral)
      }
        
        espPeripheral.delegate = self

      print("Peripheral Discovered: \(peripheral)")
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        stopScanning()
        espPeripheral.discoverServices([BLEService_UUID])
    }
}

extension BT: CBPeripheralDelegate {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {

      guard let services = peripheral.services else { return }
      for service in services {
        peripheral.discoverCharacteristics(nil, for: service)
      }
      connectedService = services[0]
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

        guard let characteristics = service.characteristics else {
            return
        }

        print("Found \(characteristics.count) characteristics.")
        for characteristic in characteristics {
            for i in 0...1 {
                if characteristic.uuid.isEqual(charUuid[i]) {
                    char[i] = characteristic
                    print("Characteristic: \(characteristic.uuid)")
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        guard characteristic == char[1],

            let characteristicValue = characteristic.value,
            let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }

        print("Value Recieved: \((ASCIIstring as String))")
        
        //parse the status
        //char[1] has motor x homed, motor x home sensor, motor x pos, motor x target, motor x speed
        let array = String(ASCIIstring).components(separatedBy: ",")
        if array.count == 12 {
            motorX.homed = array[0] == "1"
            motorX.home = array[1] == "1"
            motorX.position = Int(array[2]) ?? 0
            motorX.target = Int(array[3]) ?? 0
            motorX.speed = Double(array[4]) ?? 0
            
            motorZ.homed = array[5] == "1"
            motorZ.home = array[6] == "1"
            motorZ.position = Int(array[7]) ?? 0
            motorZ.target = Int(array[8]) ?? 0
            motorZ.speed = Double(array[9]) ?? 0
            motorZ.force = Double(array[10]) ?? 0
            motorZ.targetForce = Double(array[11]) ?? 0
        }
    }


  func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
      guard error == nil else {
          print("Error discovering services: error")
          return
      }
    print("Function: \(#function),Line: \(#line)")
      print("Message sent")
  }

}
