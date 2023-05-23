import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'generated/plugindata.pb.dart' as pb;
import 'model/ble_status.dart';
import 'model/device_event.dart';
import 'model/scan_config.dart';
import 'vtble_plugin_platform_interface.dart';

/// An implementation of [VtblePluginPlatform] that uses method channels.
class MethodChannelVtblePlugin extends VtblePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('vtble_plugin');

  MethodChannelVtblePlugin({
    required Stream<List<int>> scanStream,
    required Stream<List<int>> connectStream,
    required Stream<List<int>> statusStream,
    required Stream<List<int>> bleStatusStream,
  })  : _scanRawStream = scanStream,
        _connectRawStream = connectStream,
        _statusRawStream = scanStream,
        _bleStatusRawStream = bleStatusStream;

  final Stream<List<int>> _scanRawStream;
  final Stream<List<int>> _connectRawStream;
  final Stream<List<int>> _statusRawStream;
  final Stream<List<int>> _bleStatusRawStream;

  Stream<ScanEvent>? _scanStream;
  Stream<ConnectEvent>? _connectStream;
  Stream<SdkEvent>? _statusStream;
  Stream<BleStatus>? _bleStatusStream;

  @override
  Stream<ScanEvent> get scanStream => _scanStream ??= _scanRawStream.map((event) => pb.DeviceEvent.fromBuffer(event)).map((event) => ScanEvent(
      type: ScanEvent.getEventType(event.type),
      deviceInfo: event.hasDeviceInfo()
          ? DeviceInfo(
              name: event.deviceInfo.hasName() ? event.deviceInfo.name : null,
              firmWareVersion: event.deviceInfo.hasFirmWareVersion() ? event.deviceInfo.firmWareVersion : null,
              uuid: event.deviceInfo.hasUuid() ? event.deviceInfo.uuid : null,
              isDualMotor: event.deviceInfo.hasIsDualMotor() ? event.deviceInfo.isDualMotor : false,
              isDualLed: event.deviceInfo.hasIsDualLed() ? event.deviceInfo.isDualLed : false,
              identifier: event.deviceInfo.hasIdentifier()
                  ? ScanType(
                      protocol: event.deviceInfo.identifier.protocol,
                      deviceType: event.deviceInfo.identifier.deviceType,
                      subType: event.deviceInfo.identifier.subType,
                      vendor: event.deviceInfo.identifier.vendor)
                  : null,
            )
          : null));

  @override
  Stream<ConnectEvent> get connectStream => _connectStream ??= _connectRawStream.map((event) => pb.DeviceEvent.fromBuffer(event)).map((event) => ConnectEvent(
      type: ConnectEvent.getEventType(event.type),
      deviceInfo: event.hasDeviceInfo()
          ? DeviceInfo(
              name: event.deviceInfo.hasName() ? event.deviceInfo.name : null,
              firmWareVersion: event.deviceInfo.hasFirmWareVersion() ? event.deviceInfo.firmWareVersion : null,
              uuid: event.deviceInfo.hasUuid() ? event.deviceInfo.uuid : null,
              isDualMotor: event.deviceInfo.hasIsDualMotor() ? event.deviceInfo.isDualMotor : false,
              isDualLed: event.deviceInfo.hasIsDualLed() ? event.deviceInfo.isDualLed : false,
              identifier: event.deviceInfo.hasIdentifier()
                  ? ScanType(
                      protocol: event.deviceInfo.identifier.protocol,
                      deviceType: event.deviceInfo.identifier.deviceType,
                      subType: event.deviceInfo.identifier.subType,
                      vendor: event.deviceInfo.identifier.vendor)
                  : null,
            )
          : null));

  @override
  Stream<SdkEvent> get statusStream => _statusStream ??= _statusRawStream.map((event) => pb.DeviceEvent.fromBuffer(event)).map((event) => SdkEvent(
      type: SdkEvent.getEventType(event.type),
      deviceInfo: event.hasDeviceInfo()
          ? DeviceInfo(
              name: event.deviceInfo.hasName() ? event.deviceInfo.name : null,
              firmWareVersion: event.deviceInfo.hasFirmWareVersion() ? event.deviceInfo.firmWareVersion : null,
              uuid: event.deviceInfo.hasUuid() ? event.deviceInfo.uuid : null,
              isDualMotor: event.deviceInfo.hasIsDualMotor() ? event.deviceInfo.isDualMotor : false,
              isDualLed: event.deviceInfo.hasIsDualLed() ? event.deviceInfo.isDualLed : false,
              identifier: event.deviceInfo.hasIdentifier()
                  ? ScanType(
                      protocol: event.deviceInfo.identifier.protocol,
                      deviceType: event.deviceInfo.identifier.deviceType,
                      subType: event.deviceInfo.identifier.subType,
                      vendor: event.deviceInfo.identifier.vendor)
                  : null,
            )
          : null));

  @override
  Stream<BleStatus> get bleStatusStream => _bleStatusStream ??= _bleStatusRawStream.map((event) => pb.BleStatusInfo.fromBuffer(event)).map((event) => BleStatus.values[event.status]);

  @override
  void writeMotor(int value) {
    // final motorDataRequest = pb.MotorDataRequest.create()..value = value;
    // await methodChannel.invokeMethod('writeMotor', motorDataRequest.writeToBuffer());
    methodChannel.invokeMethod('writeMotor', value);
  }

  @override
  void stopVibrate() {
    methodChannel.invokeMethod('stopVibrate');
  }

  @override
  void writeMotorLED(int motor, int led) {
    methodChannel.invokeMethod('writeMotorLED', {'motor': motor, 'led': led});
  }

  @override
  void writeDualMotorLED(int motor1, int motor2, int led) {
    methodChannel.invokeMethod('writeDualMotorLED', {'motor1': motor1, 'motor2': motor2, 'led': led});
  }

  @override
  void writeDualMotorDualLED(int motor1, int motor2, int led1, int led2) {
    methodChannel.invokeMethod('writeDualMotorDualLED', {'motor1': motor1, 'motor2': motor2, 'led1': led1, 'led2': led2});
  }

  @override
  void writeLed(int led) {
    methodChannel.invokeMethod('writeLed', {'led': led});
  }

  @override
  void writeCloseLed() {
    methodChannel.invokeMethod('writeCloseLed');
  }

  @override
  Future<bool> isConnected() async {
    final isConnected = await methodChannel.invokeMethod<bool>('isConnected');
    return isConnected ?? false;
  }

  @override
  Future<void> connect(String uuid) async {
    final connectRequest = pb.ConnectRequest.create()..uuid = uuid;
    await methodChannel.invokeMethod('connect', connectRequest.writeToBuffer());
  }

  @override
  Future<bool> isScanning() async {
    final isScanning = await methodChannel.invokeMethod<bool>('isScanning');
    return isScanning ?? false;
  }

  @override
  Future<void> stopScan() async {
    await methodChannel.invokeMethod('stopScan');
  }

  @override
  Future<void> startScan(ScanConfig config) async {
    final request = pb.ScanForDevicesRequest(
      timeoutInSeconds: config.timeoutInSecond,
      scanConfig: pb.ScanConfigRequest(mac: config.scanDevice.mac, scanOnly: config.scanDevice.scanOnly),
      scanDeviceTypes: config.scanTypes.map((e) => pb.ScanDeviceType(protocol: e.protocol, deviceType: e.deviceType, subType: e.subType, vendor: e.vendor)),
    );
    await methodChannel.invokeMethod('startScan', request.writeToBuffer());
  }

  @override
  Future<bool> openLocationService() async {
    if (Platform.isAndroid) {
      return await methodChannel.invokeMethod('openLocationService');
    } else {
      return false;
    }
  }

  @override
  Future<bool> openBluetoothService() async {
    if (Platform.isAndroid) {
      return await methodChannel.invokeMethod('openBluetoothService');
    } else {
      return false;
    }
  }

  @override
  Future<void> setLogEnable(bool isEnable) async {
    await methodChannel.invokeMethod('setLogEnable', isEnable);
  }

  @override
  Future<void> moveToBack() async {
    if (Platform.isAndroid) {
      await methodChannel.invokeMethod('moveToBack');
    }
  }

  @override
  Future<void> setKey(String key) async {
    await methodChannel.invokeMethod('setKey', key);
  }

  @override
  Future<bool> applyPermission() async {
    final result = await methodChannel.invokeMethod<bool>('applyPermission');
    return result ?? false;
  }

  @override
  Future<BleStatus> checkBleState() async {
    final result = await methodChannel.invokeMethod<Uint8List>('checkBleState');
    if (result != null) {
      var statusInfo = pb.BleStatusInfo.fromBuffer(result);
      return BleStatus.values[statusInfo.status];
    }
    return BleStatus.unknown;
  }

  @override
  Future<void> setCommandInterval(int interval) async {
    if (Platform.isAndroid) {
      return await methodChannel.invokeMethod('setCommandInterval', {'interval': interval});
    } else {
      return;
    }
  }
}

class MethodChannelVtblePluginFactory {
  static MethodChannelVtblePlugin create() {
    const scanEventChannel = EventChannel('ble_plugin_scan');
    const connectEventChannel = EventChannel('ble_plugin_connect');
    const statusEventChannel = EventChannel('ble_plugin_status');
    const bleStatusEventChannel = EventChannel('ble_plugin_ble_status');

    return MethodChannelVtblePlugin(
        scanStream: scanEventChannel.receiveBroadcastStream().cast<List<int>>(),
        connectStream: connectEventChannel.receiveBroadcastStream().cast<List<int>>(),
        statusStream: statusEventChannel.receiveBroadcastStream().cast<List<int>>(),
        bleStatusStream: bleStatusEventChannel.receiveBroadcastStream().cast<List<int>>());
  }
}
