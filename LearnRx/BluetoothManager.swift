//
//  BluetoothManager.swift
//  LearnRx
//
//  Created by Yosef Shachnovsky on 16/01/2020.
//  Copyright © 2020 Yosef Shachnovsky. All rights reserved.
//

import Foundation
import CoreBluetooth


//class BluetoothManager: NSObject {
//
//    var centralManager: CBCentralManager!
//   var peripheral: CBPeripheral?
//   var bluetoothConfig: BluetoothConfig!
//
//   var allCharacteristicsIds: [CBUUID]!
//   var discoveredCharacteristics = [CBUUID: CBCharacteristic]()
//
//   var queue: DispatchQueue
//
//}
//
//// MARK: - CBCentralManagerDelegate
//extension BluetoothManager: CBCentralManagerDelegate {
//
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        OrcamLogger.info("BT: centralManagerDidUpdateState: \(central.state)")
//        centralState.onNext(central.state)
//        if central.state == .poweredOn {
//            if shouldAutoConnect {
//                OrcamLogger.info("BT: Going to perform connect sequence")
//                performConnectSequence()
//            } else {
//                OrcamLogger.info("BT: Skipping connect because shouldAutoConnect is false")
//            }
//        } else if central.state == .poweredOff {
//            delegate?.bluetoothManagerDidReceiveError(error: .deviceBluetoothIsOff)
//            OrcamLogger.warning("BT: Central state is poweredOff")
//            assignBluetoothStateAndNotify(.disconnected, peripheralUUIDString: nil)
//        } else {
//            OrcamLogger.error("BT: No bluetooth available - centralManagerDidUpdateState: \(central.state)")
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        OrcamLogger.info("BT: Peripheral discovered: \(peripheral.identifier), rssi: \(RSSI)")
//        if peripheral == self.peripheral {
//            centralManager.stopScan()
//            connectToPeripheral(peripheral: peripheral, options: nil)
//        }else if advertisementData[CBAdvertisementDataLocalNameKey] as? String == deviceName, let dataDict = advertisementData[CBAdvertisementDataServiceDataKey] as? [CBUUID: Data] {
//            // We found an OrCam device
//            if dataDict[UUID_CONTROL_SERVICE]?.first == 255 {
//                centralManager.stopScan()
//                OrcamLogger.event("BT_\(deviceName)_CONNECTING")
//                OrcamLogger.info("BT: Discovered a peripheral we will attempt to connect to, UUID: \(peripheral.identifier)")
//                connectToPeripheral(peripheral: peripheral, options: nil)
//            }  else {
//                if peripheralConnectivityState != .scanning {
//                    OrcamLogger.event("BT_\(deviceName)_FOUND")
//                    OrcamLogger.info("BT: Discovered a peripheral we want to connect to, requesting user to advertise, UUID: \(peripheral.identifier)")
//                    assignBluetoothStateAndNotify(.scanning, peripheralUUIDString: peripheral.identifier.uuidString)
//                }
//            }
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        OrcamLogger.info("BT: Did connect to peripheral")
//        peripheral.delegate = self
//        assignBluetoothStateAndNotify(.pairing, peripheralUUIDString: peripheral.identifier.uuidString)
//        peripheral.discoverServices([UUID_BATTERY_SERVICE])
//
//    }
//
//    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        OrcamLogger.event("BT_CONNECTION_FAILED")
//        OrcamLogger.error("BT: Failed to connect, lastKnownState: \(peripheralConnectivityState)")
//        assignBluetoothStateAndNotify(.disconnected, peripheralUUIDString: peripheral.identifier.uuidString)
//        performConnectSequence()
//    }
//
//    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        self.peripheral = nil
//        OrcamLogger.event("BT_DID_DISCONNECT")
//        OrcamLogger.error("BT: Peripheral disconnected, lastKnownState:\(peripheralConnectivityState), error: \(String(describing: error))")
//        if peripheralConnectivityState == .disconnecting {
//            assignBluetoothStateAndNotify(.forceDisconnect, peripheralUUIDString: peripheral.identifier.uuidString)
//        } else {
//            assignBluetoothStateAndNotify(.disconnected, peripheralUUIDString: peripheral.identifier.uuidString)
//            performConnectSequence()
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
//        OrcamLogger.info("BT: Bluetooth restoration")
//        if let peripherals = dict[CBCentralManagerRestoredStatePeripheralsKey], let peripheralArray = peripherals as? Array<CBPeripheral>, let restorationPeripheral = peripheralArray.first {
//            peripheralArray.forEach({ print("restoration peripheral: \($0)")})
//            if let storedUUID = deviceUUID, storedUUID == restorationPeripheral.identifier {
//                peripheral = restorationPeripheral
//                OrcamLogger.debug("BT: Storing restored peripheral: \(restorationPeripheral)")
//            } else {
//                OrcamLogger.warning("BT: Received unknown connected peripheral in restoration which doesn't match our stored device uuid, storedUUID: \(deviceUUID?.uuidString ?? "no device UUID"), restoration device UUID: \(restorationPeripheral.identifier)")
//            }
//        }
//    }
//}
//
