///
//  Generated code. Do not modify.
//  source: plugindata.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BleStatusInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BleStatusInfo', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  BleStatusInfo._() : super();
  factory BleStatusInfo({
    $core.int? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory BleStatusInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BleStatusInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BleStatusInfo clone() => BleStatusInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BleStatusInfo copyWith(void Function(BleStatusInfo) updates) => super.copyWith((message) => updates(message as BleStatusInfo)) as BleStatusInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BleStatusInfo create() => BleStatusInfo._();
  BleStatusInfo createEmptyInstance() => create();
  static $pb.PbList<BleStatusInfo> createRepeated() => $pb.PbList<BleStatusInfo>();
  @$core.pragma('dart2js:noInline')
  static BleStatusInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BleStatusInfo>(create);
  static BleStatusInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get status => $_getIZ(0);
  @$pb.TagNumber(1)
  set status($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class ScanDeviceType extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScanDeviceType', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocol', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceType', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subType', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vendor', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ScanDeviceType._() : super();
  factory ScanDeviceType({
    $core.int? protocol,
    $core.int? deviceType,
    $core.int? subType,
    $core.int? vendor,
  }) {
    final _result = create();
    if (protocol != null) {
      _result.protocol = protocol;
    }
    if (deviceType != null) {
      _result.deviceType = deviceType;
    }
    if (subType != null) {
      _result.subType = subType;
    }
    if (vendor != null) {
      _result.vendor = vendor;
    }
    return _result;
  }
  factory ScanDeviceType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScanDeviceType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScanDeviceType clone() => ScanDeviceType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScanDeviceType copyWith(void Function(ScanDeviceType) updates) => super.copyWith((message) => updates(message as ScanDeviceType)) as ScanDeviceType; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScanDeviceType create() => ScanDeviceType._();
  ScanDeviceType createEmptyInstance() => create();
  static $pb.PbList<ScanDeviceType> createRepeated() => $pb.PbList<ScanDeviceType>();
  @$core.pragma('dart2js:noInline')
  static ScanDeviceType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScanDeviceType>(create);
  static ScanDeviceType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get protocol => $_getIZ(0);
  @$pb.TagNumber(1)
  set protocol($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProtocol() => $_has(0);
  @$pb.TagNumber(1)
  void clearProtocol() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get deviceType => $_getIZ(1);
  @$pb.TagNumber(2)
  set deviceType($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeviceType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceType() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get subType => $_getIZ(2);
  @$pb.TagNumber(3)
  set subType($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSubType() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubType() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get vendor => $_getIZ(3);
  @$pb.TagNumber(4)
  set vendor($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVendor() => $_has(3);
  @$pb.TagNumber(4)
  void clearVendor() => clearField(4);
}

class ScanConfigRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScanConfigRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mac')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanOnly')
    ..hasRequiredFields = false
  ;

  ScanConfigRequest._() : super();
  factory ScanConfigRequest({
    $core.String? mac,
    $core.bool? scanOnly,
  }) {
    final _result = create();
    if (mac != null) {
      _result.mac = mac;
    }
    if (scanOnly != null) {
      _result.scanOnly = scanOnly;
    }
    return _result;
  }
  factory ScanConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScanConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScanConfigRequest clone() => ScanConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScanConfigRequest copyWith(void Function(ScanConfigRequest) updates) => super.copyWith((message) => updates(message as ScanConfigRequest)) as ScanConfigRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScanConfigRequest create() => ScanConfigRequest._();
  ScanConfigRequest createEmptyInstance() => create();
  static $pb.PbList<ScanConfigRequest> createRepeated() => $pb.PbList<ScanConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static ScanConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScanConfigRequest>(create);
  static ScanConfigRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mac => $_getSZ(0);
  @$pb.TagNumber(1)
  set mac($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMac() => $_has(0);
  @$pb.TagNumber(1)
  void clearMac() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get scanOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set scanOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScanOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearScanOnly() => clearField(2);
}

class ScanForDevicesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScanForDevicesRequest', createEmptyInstance: create)
    ..pc<ScanDeviceType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanDeviceTypes', $pb.PbFieldType.PM, subBuilder: ScanDeviceType.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeoutInSeconds', $pb.PbFieldType.O3)
    ..aOM<ScanConfigRequest>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scanConfig', subBuilder: ScanConfigRequest.create)
    ..hasRequiredFields = false
  ;

  ScanForDevicesRequest._() : super();
  factory ScanForDevicesRequest({
    $core.Iterable<ScanDeviceType>? scanDeviceTypes,
    $core.int? timeoutInSeconds,
    ScanConfigRequest? scanConfig,
  }) {
    final _result = create();
    if (scanDeviceTypes != null) {
      _result.scanDeviceTypes.addAll(scanDeviceTypes);
    }
    if (timeoutInSeconds != null) {
      _result.timeoutInSeconds = timeoutInSeconds;
    }
    if (scanConfig != null) {
      _result.scanConfig = scanConfig;
    }
    return _result;
  }
  factory ScanForDevicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScanForDevicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScanForDevicesRequest clone() => ScanForDevicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScanForDevicesRequest copyWith(void Function(ScanForDevicesRequest) updates) => super.copyWith((message) => updates(message as ScanForDevicesRequest)) as ScanForDevicesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScanForDevicesRequest create() => ScanForDevicesRequest._();
  ScanForDevicesRequest createEmptyInstance() => create();
  static $pb.PbList<ScanForDevicesRequest> createRepeated() => $pb.PbList<ScanForDevicesRequest>();
  @$core.pragma('dart2js:noInline')
  static ScanForDevicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScanForDevicesRequest>(create);
  static ScanForDevicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ScanDeviceType> get scanDeviceTypes => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get timeoutInSeconds => $_getIZ(1);
  @$pb.TagNumber(2)
  set timeoutInSeconds($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimeoutInSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeoutInSeconds() => clearField(2);

  @$pb.TagNumber(3)
  ScanConfigRequest get scanConfig => $_getN(2);
  @$pb.TagNumber(3)
  set scanConfig(ScanConfigRequest v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasScanConfig() => $_has(2);
  @$pb.TagNumber(3)
  void clearScanConfig() => clearField(3);
  @$pb.TagNumber(3)
  ScanConfigRequest ensureScanConfig() => $_ensure(2);
}

class ConnectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  ConnectRequest._() : super();
  factory ConnectRequest({
    $core.String? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    return _result;
  }
  factory ConnectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectRequest clone() => ConnectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectRequest copyWith(void Function(ConnectRequest) updates) => super.copyWith((message) => updates(message as ConnectRequest)) as ConnectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectRequest create() => ConnectRequest._();
  ConnectRequest createEmptyInstance() => create();
  static $pb.PbList<ConnectRequest> createRepeated() => $pb.PbList<ConnectRequest>();
  @$core.pragma('dart2js:noInline')
  static ConnectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectRequest>(create);
  static ConnectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);
}

class MotorDataRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MotorDataRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  MotorDataRequest._() : super();
  factory MotorDataRequest({
    $core.int? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory MotorDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MotorDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MotorDataRequest clone() => MotorDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MotorDataRequest copyWith(void Function(MotorDataRequest) updates) => super.copyWith((message) => updates(message as MotorDataRequest)) as MotorDataRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MotorDataRequest create() => MotorDataRequest._();
  MotorDataRequest createEmptyInstance() => create();
  static $pb.PbList<MotorDataRequest> createRepeated() => $pb.PbList<MotorDataRequest>();
  @$core.pragma('dart2js:noInline')
  static MotorDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MotorDataRequest>(create);
  static MotorDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class DeviceInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeviceInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firmWareVersion')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDualMotor')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDualLed')
    ..aOM<ScanDeviceType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identifier', subBuilder: ScanDeviceType.create)
    ..hasRequiredFields = false
  ;

  DeviceInfo._() : super();
  factory DeviceInfo({
    $core.String? name,
    $core.String? firmWareVersion,
    $core.String? uuid,
    $core.bool? isDualMotor,
    $core.bool? isDualLed,
    ScanDeviceType? identifier,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (firmWareVersion != null) {
      _result.firmWareVersion = firmWareVersion;
    }
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (isDualMotor != null) {
      _result.isDualMotor = isDualMotor;
    }
    if (isDualLed != null) {
      _result.isDualLed = isDualLed;
    }
    if (identifier != null) {
      _result.identifier = identifier;
    }
    return _result;
  }
  factory DeviceInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceInfo clone() => DeviceInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceInfo copyWith(void Function(DeviceInfo) updates) => super.copyWith((message) => updates(message as DeviceInfo)) as DeviceInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeviceInfo create() => DeviceInfo._();
  DeviceInfo createEmptyInstance() => create();
  static $pb.PbList<DeviceInfo> createRepeated() => $pb.PbList<DeviceInfo>();
  @$core.pragma('dart2js:noInline')
  static DeviceInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceInfo>(create);
  static DeviceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firmWareVersion => $_getSZ(1);
  @$pb.TagNumber(2)
  set firmWareVersion($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirmWareVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirmWareVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get uuid => $_getSZ(2);
  @$pb.TagNumber(3)
  set uuid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUuid() => $_has(2);
  @$pb.TagNumber(3)
  void clearUuid() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isDualMotor => $_getBF(3);
  @$pb.TagNumber(4)
  set isDualMotor($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsDualMotor() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsDualMotor() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isDualLed => $_getBF(4);
  @$pb.TagNumber(5)
  set isDualLed($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsDualLed() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsDualLed() => clearField(5);

  @$pb.TagNumber(6)
  ScanDeviceType get identifier => $_getN(5);
  @$pb.TagNumber(6)
  set identifier(ScanDeviceType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdentifier() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdentifier() => clearField(6);
  @$pb.TagNumber(6)
  ScanDeviceType ensureIdentifier() => $_ensure(5);
}

class DeviceEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeviceEvent', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOM<DeviceInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceInfo', subBuilder: DeviceInfo.create)
    ..hasRequiredFields = false
  ;

  DeviceEvent._() : super();
  factory DeviceEvent({
    $core.String? type,
    DeviceInfo? deviceInfo,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (deviceInfo != null) {
      _result.deviceInfo = deviceInfo;
    }
    return _result;
  }
  factory DeviceEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceEvent clone() => DeviceEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceEvent copyWith(void Function(DeviceEvent) updates) => super.copyWith((message) => updates(message as DeviceEvent)) as DeviceEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeviceEvent create() => DeviceEvent._();
  DeviceEvent createEmptyInstance() => create();
  static $pb.PbList<DeviceEvent> createRepeated() => $pb.PbList<DeviceEvent>();
  @$core.pragma('dart2js:noInline')
  static DeviceEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceEvent>(create);
  static DeviceEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  DeviceInfo get deviceInfo => $_getN(1);
  @$pb.TagNumber(2)
  set deviceInfo(DeviceInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeviceInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceInfo() => clearField(2);
  @$pb.TagNumber(2)
  DeviceInfo ensureDeviceInfo() => $_ensure(1);
}

