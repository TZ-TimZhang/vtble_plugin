//
//  SwiftBlePlugin.swift
//  ble_plugin
//
//  Created by 张利彬 on 2023/2/20.
//

import Flutter
import enum SwiftProtobuf.BinaryEncodingError
import CoreBluetooth

import Flutter

var log = true

public class SwiftBlePlugin: NSObject, FlutterPlugin  {
    private let context = PluginController()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "ble_plugin", binaryMessenger: registrar.messenger())
        let plugin = SwiftBlePlugin()
        registrar.addMethodCallDelegate(plugin, channel: methodChannel)
        
        FlutterEventChannel(name: "ble_plugin_scan", binaryMessenger: registrar.messenger())
            .setStreamHandler(plugin.scanStreamHandler)
        
        FlutterEventChannel(name: "ble_plugin_connect", binaryMessenger: registrar.messenger())
            .setStreamHandler(plugin.connectStreamHandler)
        
        FlutterEventChannel(name: "ble_plugin_status", binaryMessenger: registrar.messenger())
            .setStreamHandler(plugin.statusStreamHandler)
        
        FlutterEventChannel(name: "ble_plugin_ble_status", binaryMessenger: registrar.messenger())
            .setStreamHandler(plugin.bleStatusStreamHandler)
    }
    
    var scanStreamHandler: StreamHandler<PluginController> {
            return StreamHandler(
                name: "scan stream handler",
                context: context,
                onListen: { context, sink in
                    context.scanSink = sink
                    return nil
                },
                onCancel: { context in
                    context.scanSink = nil
                    return nil
                }
            )
        }

    var connectStreamHandler: StreamHandler<PluginController> {
            return StreamHandler(
                name: "connect stream handler",
                context: context,
                onListen: { context, sink in
                    context.connectSink = sink
                    return nil
                },
                onCancel: {context in
                    context.connectSink = nil
                    return nil
                }
            )
        }
    
    var statusStreamHandler: StreamHandler<PluginController> {
            return StreamHandler(
                name: "status stream handler",
                context: context,
                onListen: { context, sink in
                    context.stateSink = sink
                    return nil
                },
                onCancel: {context in
                    context.stateSink = nil
                    return nil
                }
            )
        }
    
    var bleStatusStreamHandler: StreamHandler<PluginController> {
            return StreamHandler(
                name: "ble status stream handler",
                context: context,
                onListen: { context, sink in
                    context.bleStateSink = sink
                    return nil
                },
                onCancel: {context in
                    context.bleStateSink = nil
                    return nil
                }
            )
        }
    
    public func isConnected() -> Bool {
        return context.mDevice != nil && (context.mDevice?.connected ?? false);
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        if(call.method == "setLogEnable") {
            // 设置是否开启日志
            log = call.arguments as? Bool ?? true
            VTDeviceManager.setLogEnabled(log)
            result("success")
        } else if (call.method == "checkBleState") {
            // 检查蓝牙状态
            let stateToReport = context.central?.state ?? .unknown
            let message = BleStatusInfo.with { $0.status = context.encode(stateToReport) }
            do{
                let binaryData: Data = try message.serializedData()
                result(binaryData)
            } catch {
                DBLog.cat("检查蓝牙状态失败")
                result("检查蓝牙状态失败");
            }
            
        } else if (call.method == "applyPermission") {
            // 请求相关权限
            let stateToReport = context.central?.state ?? .unknown
            result(stateToReport != .unauthorized)
        } else if (call.method == "openBluetoothService") {
            // 打开蓝牙
        } else if (call.method == "openLocationService") {
            // 打开定位
        } else if (call.method == "setKey") {
            // 设置key
            context.deviceManager?.key = call.arguments as! String;
            result("success")
            
        } else if (call.method == "startScan") {
            // 开始扫描
            let flutterData = call.arguments as! FlutterStandardTypedData;
            guard let request = try? ScanForDevicesRequest(serializedData: flutterData.data)
            else{
                result("fail, 开始扫描解析失败")
                return
            }
            DBLog.cat("扫描参数：\(request)")
            context.scanConfig = request.scanConfig
            var models = [VTModelIdentifier]()
            for temp in request.scanDeviceTypes {
                models.append(VTModelIdentifier.init(version: temp.`protocol` as NSNumber, type: temp.deviceType as NSNumber, subtype: temp.subType as NSNumber, vendor: temp.vendor as NSNumber))
            }
            
            context.deviceManager?.scanForDevices(with: models, timeout: Double(request.timeoutInSeconds))
            result("success")
            
        } else if (call.method == "stopScan") {
            // 停止扫描
            context.deviceManager?.stopScan();
            result("success")
        } else if (call.method == "isScanning") {
            // 是否扫描中
            
            result(context.deviceManager?.isScanning)
        } else if (call.method == "connect") {
            // 连接
            let flutterData = call.arguments as! FlutterStandardTypedData;
            guard let request = try? ConnectRequest(serializedData: flutterData.data)
            else{
                result("fail, 链接参数解析失败")
                return
            }
         
            let index = context.discoverdDevice.firstIndex { mDevice in
                return mDevice.uuidString == request.uuid
            }
            if (index != nil)  {
                let device = context.discoverdDevice[index!]
                context.deviceManager?.connect(device)
                result("success")
            } else {
                result("fail,未查询到对应的device")
            }
        } else if (call.method == "isConnected") {
            // 是否已连接
            result(isConnected())
        } else if (call.method == "writeMotor") {
            // 写入震动数据
            DBLog.cat("写入震动数据参数: \(String(describing: call.arguments))")
            
            context.mDevice?.setMotorVibrationStrength((call.arguments as! NSNumber).uint8Value)
            result("success")
        } else if (call.method == "stopVibrate") {
            // 停止震动数据
            context.mDevice?.setMotorVibrationStrength(0)
            result("success")
        } else if (call.method == "writeMotorLED") {
            // 写入LED
            let dic = call.arguments as! Dictionary<String, UInt8>;
            guard let motor = dic["motor"]
            else {
                DBLog.error.cat("写入一个强度加led值motor错误: \(String(describing: dic["motor"]))")
                result("写入一个强度值motor错误")
                return
            }
            guard let led = dic["led"]
            else {
                DBLog.error.cat("写入一个强度值led错误: \(String(describing: dic["led"]))")
                result("写入一个强度值led错误")
                return
            }
            context.mDevice?.setMotorVibrationStrength(motor, led: led)
            result("success")
        } else if (call.method == "writeDualMotorLED") {
            // 写入LED
            let dic = call.arguments as! Dictionary<String, UInt8>;
            guard let motor1 = dic["motor1"]
            else {
                DBLog.error.cat("写入两个强度加led值motor1错误: \(String(describing: dic["motor1"]))")
                result("写入两个强度加led值motor1错误")
                return
            }
            guard let motor2 = dic["motor2"]
            else {
                DBLog.error.cat("写入两个强度加led值motor2错误: \(String(describing: dic["motor2"]))")
                result("写入两个强度加led值motor2错误")
                return
            }
            guard let led = dic["led"]
            else {
                DBLog.error.cat("写入两个强度加led值led错误: \(String(describing: dic["led"]))")
                result("写入两个强度加led值led错误")
                return
            }
            
            context.mDevice?.setMotor1VibrationStrength(motor1, motor2VibrationStrength: motor2, led: led)
            result("success")
        } else if (call.method == "writeLed") {
            // 写入led
            
            context.mDevice?.setLED((call.arguments as! NSNumber).uint8Value)
            result("success")
        } else if (call.method == "writeCloseLed") {
            // 关闭led
        
            context.mDevice?.closeLED()
            result("success")
        } else if (call.method == "writeDualMotorDualLED") {
            // 双灯双马达
            let dic = call.arguments as! Dictionary<String, UInt8>;
            guard let motor1 = dic["motor1"]
            else {
                DBLog.error.cat("写入两个强度加两个led值motor1错误: \(String(describing: dic["motor1"]))")
                result("写入两个强度加led值motor1错误")
                return
            }
            guard let motor2 = dic["motor2"]
            else {
                DBLog.error.cat("写入两个强度加两个led值motor2错误: \(String(describing: dic["motor2"]))")
                result("写入两个强度加led值motor2错误")
                return
            }
            guard let led1 = dic["led1"]
            else {
                DBLog.error.cat("写入两个强度加两个led值led1错误: \(String(describing: dic["led1"]))")
                result("写入两个强度加两个led值led1错误")
                return
            }
            guard let led2 = dic["led2"]
            else {
                DBLog.error.cat("写入两个强度加两个led值led2错误: \(String(describing: dic["led2"]))")
                result("写入两个强度加两个led值led2错误")
                return
            }
            
            context.mDevice?.setMotor1VibrationStrength(motor1, motor2VibrationStrength: motor2, led: led1)
            result("success")
        } else {
            result("fail, 暂未实现")
        }
        
        
    }
    
}
