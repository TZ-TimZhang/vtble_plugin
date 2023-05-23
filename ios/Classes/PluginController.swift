//
//  PluginController.swift
//  ble_plugin
//
//  Created by 张利彬 on 2023/2/20.
//

import Flutter
import Foundation
import class CoreBluetooth.CBUUID
import class CoreBluetooth.CBService
import enum CoreBluetooth.CBManagerState
import var CoreBluetooth.CBAdvertisementDataServiceDataKey
import var CoreBluetooth.CBAdvertisementDataServiceUUIDsKey
import var CoreBluetooth.CBAdvertisementDataManufacturerDataKey
import var CoreBluetooth.CBAdvertisementDataLocalNameKey
import CoreBluetooth



final class PluginController: NSObject, VTDeviceManagerDelegate, CBCentralManagerDelegate {
    
    
    
    var deviceManager: VTDeviceManager?
    var discoverdDevice: [VTDevice]
    var central: CBCentralManager?
    var scanConfig: ScanConfigRequest
    var scanSink: EventSink?
    var connectSink: EventSink?
    var stateSink: EventSink?
    var bleStateSink: EventSink? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.reportState()
            }
        }
    }
    
//    当前设备
    var mDevice: VTDevice?
    
    override init() {
        scanConfig = ScanConfigRequest()
        discoverdDevice = []
        super.init()
        
        deviceManager = VTDeviceManager()
        deviceManager?.delegate = self
        central = CBCentralManager.init(delegate: self, queue: nil)
        
    }
    
    /**
     蓝牙状态的监听
     */
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        reportState(central.state)
    }
    
    
    func encode(_ centralState: CBManagerState) -> Int32 {
        switch (centralState) {
        case .unknown, .resetting:
            return 0
        case .unsupported:
            return 1
        case .unauthorized:
            return 2
        case .poweredOff:
            return 3
        case .poweredOn:
            return 5
        @unknown default:
            return 0
        }
    }
    
    
    /**
     是否正在扫描设备
     */
    func deviceManager(_ deviceManager: VTDeviceManager, isScanning: Bool) {
        DBLog.cat("是否正在扫描设备, \(isScanning)")
        guard let sink = scanSink
        else { return }
        let message = DeviceEvent.with {
            $0.type = isScanning ? "start" : "stop"
        }
        sink.add(.success(message))
    }
    
    /**
     扫描超时
     */
    func deviceManagerScanTimeout(_ deviceManager: VTDeviceManager) {
        DBLog.cat("扫描设备超时")
        guard let sink = scanSink
        else { return }
        let message = DeviceEvent.with {
            $0.type = "timeOut"
        }
        sink.add(.success(message))
    }
    
    /**
     发现设备
     */
    func deviceManager(_ deviceManager: VTDeviceManager, didDiscover device: VTDevice, connectAndStopScan: UnsafeMutablePointer<ObjCBool>) {
        DBLog.cat("发现设备, \(device.description)")
        if (!discoverdDevice.contains(where: { mDevice in
            return mDevice.uuidString == device.uuidString
        })) {
            discoverdDevice.append(device)
        }
        guard let sink = scanSink
        else { return }
        let message = DeviceEvent.with {
            $0.type = "discovered"
            $0.deviceInfo = DeviceInfo.with{
                $0.name = device.name
//                $0.firmWareVersion = device.firmwareVersion
                $0.uuid = device.uuidString
                $0.identifier = ScanDeviceType.with{
                    $0.`protocol` = device.modelIdentifier.version.int32Value
                    $0.deviceType = device.modelIdentifier.type.int32Value
                    $0.subType = device.modelIdentifier.subtype.int32Value
                    $0.vendor = device.modelIdentifier.vendor.int32Value
                }
            }
        }
        sink.add(.success(message))
        
        if (!scanConfig.scanOnly) {
            if (scanConfig.mac.isEmpty) {
                connectAndStopScan.pointee = ObjCBool(true)
            } else {
                connectAndStopScan.pointee = ObjCBool(scanConfig.mac == device.uuidString)
            }
        } else {
            connectAndStopScan.pointee = ObjCBool(false)
        }
        
        return
    }
    
    /**
     连接上设备
     */
    func deviceManager(_ deviceManager: VTDeviceManager, didConnect device: VTDevice) {
        DBLog.cat("连接上设备, \(device.description)")
        discoverdDevice.removeAll()
        mDevice = device;
        guard let sink = connectSink
        else { return }
        mDevice?.serviceReadyHandler = {
            let message = DeviceEvent.with {
                $0.type = "serviceDiscovered"
                $0.deviceInfo = DeviceInfo.with{
                    $0.name = device.name
                    $0.firmWareVersion = device.firmwareVersion
                    $0.uuid = device.uuidString
                    $0.identifier = ScanDeviceType.with{
                        $0.`protocol` = device.modelIdentifier.version.int32Value
                        $0.deviceType = device.modelIdentifier.type.int32Value
                        $0.subType = device.modelIdentifier.subtype.int32Value
                        $0.vendor = device.modelIdentifier.vendor.int32Value
                    }
//                    $0.isDualMotor = device.isDualMotor
//                    $0.isDualLed = device.isDualLed
                    $0.isDualMotor = false;
                    $0.isDualLed = false;
                }
            }
            DBLog.cat("发送发现服务, \(device.description)")
            sink.add(.success(message))
        }
        
        let message = DeviceEvent.with {
            $0.type = "connected"
            $0.deviceInfo = DeviceInfo.with{
                $0.name = device.name
//                $0.firmWareVersion = device.firmwareVersion
                $0.uuid = device.uuidString
            }
        }
        sink.add(.success(message))
        return
    }
    
    /**
     连接出错
     */
    func deviceManager(_ deviceManager: VTDeviceManager, didFailToConnect device: VTDevice, error: Error?) {
        DBLog.error.cat("设备连接出错，\(String(describing: error?.localizedDescription))")
    }
    
    /**
     设备断开连接
     */
    func deviceManager(_ deviceManager: VTDeviceManager, didDisconnectDevice device: VTDevice, error: Error?) {
        DBLog.cat("设备断开连接, \(device.description)")
        mDevice = device;
        guard let sink = connectSink
        else { return }
        let message = DeviceEvent.with {
            $0.type = "disconnected"
            $0.deviceInfo = DeviceInfo.with{
                $0.name = device.name
                $0.uuid = device.uuidString
                $0.identifier = ScanDeviceType.with{
                    $0.`protocol` = device.modelIdentifier.version.int32Value
                    $0.deviceType = device.modelIdentifier.type.int32Value
                    $0.subType = device.modelIdentifier.subtype.int32Value
                    $0.vendor = device.modelIdentifier.vendor.int32Value
                }
            }
        }
        sink.add(.success(message))
        return
    }
    


    
    
    /**
     上报当前蓝牙的状态
     */
    func reportState(_ knownState: CBManagerState? = nil) {
        
        guard let sink = bleStateSink
        else { return }
        let stateToReport = knownState ?? central?.state ?? .unknown
        let message = BleStatusInfo.with { $0.status = encode(stateToReport) }
        
        sink.add(.success(message))
    }
    
    
    
    
}


