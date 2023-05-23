import 'scan_config.dart';

class DeviceInfo {
  final String? name;
  final String? firmWareVersion;
  final String? uuid;
  final bool isDualMotor;
  final bool isDualLed;
  final ScanType? identifier;

  DeviceInfo({
    this.name,
    this.firmWareVersion,
    this.uuid,
    this.identifier,
    required this.isDualMotor,
    required this.isDualLed,
  });

  @override
  String toString() {
    return 'DeviceInfo{name: $name, firmWareVersion: $firmWareVersion, uuid: $uuid, isDualMotor: $isDualMotor, isDualLed: $isDualLed, identifier: $identifier}';
  }

  bool isSMV28MotorNoiseDevice() {
    final versions = ['S021E.10.01.0A', 'S021E.10.02.02', 'S021E.10.02.03'];
    return versions.contains(firmWareVersion);
  }
}

enum ScanEventType {
  start,
  stop,
  timeout,
  discovered,
  unknown,
}

enum ConnectEventType {
  connected,
  disconnected,
  serviceDiscovered,
  unknown,
}

enum SdkEventType {
  init,
  connected,
  disconnected,
  unknown,
}

class ScanEvent {
  final ScanEventType type;
  final DeviceInfo? deviceInfo;

  ScanEvent({required this.type, this.deviceInfo});

  @override
  String toString() {
    return 'ScanEvent{type: $type, deviceInfo: $deviceInfo}';
  }

  static ScanEventType getEventType(String type) {
    if (type == 'start') {
      return ScanEventType.start;
    } else if (type == 'stop') {
      return ScanEventType.stop;
    } else if (type == 'timeOut') {
      return ScanEventType.timeout;
    } else if (type == 'discovered') {
      return ScanEventType.discovered;
    }
    return ScanEventType.unknown;
  }
}

class ConnectEvent {
  final ConnectEventType type;
  final DeviceInfo? deviceInfo;

  ConnectEvent({required this.type, this.deviceInfo});

  @override
  String toString() {
    return 'ConnectEvent{type: $type, deviceInfo: $deviceInfo}';
  }

  static ConnectEventType getEventType(String type) {
    if (type == 'connected') {
      return ConnectEventType.connected;
    } else if (type == 'disconnected') {
      return ConnectEventType.disconnected;
    } else if (type == 'serviceDiscovered') {
      return ConnectEventType.serviceDiscovered;
    }
    return ConnectEventType.unknown;
  }
}

class SdkEvent {
  final SdkEventType type;
  final DeviceInfo? deviceInfo;

  SdkEvent({required this.type, this.deviceInfo});

  @override
  String toString() {
    return 'SdkEvent{type: $type, deviceInfo: $deviceInfo}';
  }

  static SdkEventType getEventType(String type) {
    if (type == 'init') {
      return SdkEventType.init;
    } else if (type == 'connected') {
      return SdkEventType.connected;
    } else if (type == 'disconnected') {
      return SdkEventType.disconnected;
    }
    return SdkEventType.unknown;
  }
}
