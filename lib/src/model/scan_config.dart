class ScanType {
  final int protocol;
  final int deviceType;
  final int subType;
  final int vendor;

  ScanType({required this.protocol, required this.deviceType, required this.subType, required this.vendor});

  @override
  String toString() {
    return 'ScanType{protocol: $protocol, deviceType: $deviceType, subType: $subType, vendor: $vendor}';
  }
}

class ScanDevice {
  final String mac;
  final bool scanOnly;

  ScanDevice({required this.mac, required this.scanOnly});

  @override
  String toString() {
    return 'ScanDevice{mac: $mac, scanOnly: $scanOnly}';
  }
}

class ScanConfig {
  final List<ScanType> scanTypes;
  final int timeoutInSecond;
  final ScanDevice scanDevice;

  ScanConfig({required this.scanTypes, required this.timeoutInSecond, required this.scanDevice});

  @override
  String toString() {
    return 'ScanConfig{scanTypes: $scanTypes, timeoutInSecond: $timeoutInSecond, scanDevice: $scanDevice}';
  }
}
