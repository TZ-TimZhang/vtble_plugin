// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: plugindata.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct BleStatusInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var status: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// 扫描的用到的协议类型
struct ScanDeviceType {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var `protocol`: Int32 = 0

  var deviceType: Int32 = 0

  var subType: Int32 = 0

  var vendor: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// 扫描配置
struct ScanConfigRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var mac: String = String()

  ///    bool continue_scan = 3;
  var scanOnly: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// 扫描参数
struct ScanForDevicesRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var scanDeviceTypes: [ScanDeviceType] = []

  var timeoutInSeconds: Int32 = 0

  var scanConfig: ScanConfigRequest {
    get {return _scanConfig ?? ScanConfigRequest()}
    set {_scanConfig = newValue}
  }
  /// Returns true if `scanConfig` has been explicitly set.
  var hasScanConfig: Bool {return self._scanConfig != nil}
  /// Clears the value of `scanConfig`. Subsequent reads from it will return its default value.
  mutating func clearScanConfig() {self._scanConfig = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _scanConfig: ScanConfigRequest? = nil
}

/// 连接参数
struct ConnectRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var uuid: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// 震动参数
struct MotorDataRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var value: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

//// 设备
struct DeviceInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var firmWareVersion: String = String()

  var uuid: String = String()

  var isDualMotor: Bool = false

  var isDualLed: Bool = false

  var identifier: ScanDeviceType {
    get {return _identifier ?? ScanDeviceType()}
    set {_identifier = newValue}
  }
  /// Returns true if `identifier` has been explicitly set.
  var hasIdentifier: Bool {return self._identifier != nil}
  /// Clears the value of `identifier`. Subsequent reads from it will return its default value.
  mutating func clearIdentifier() {self._identifier = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _identifier: ScanDeviceType? = nil
}

//// 设备事件
struct DeviceEvent {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var type: String = String()

  var deviceInfo: DeviceInfo {
    get {return _deviceInfo ?? DeviceInfo()}
    set {_deviceInfo = newValue}
  }
  /// Returns true if `deviceInfo` has been explicitly set.
  var hasDeviceInfo: Bool {return self._deviceInfo != nil}
  /// Clears the value of `deviceInfo`. Subsequent reads from it will return its default value.
  mutating func clearDeviceInfo() {self._deviceInfo = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _deviceInfo: DeviceInfo? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension BleStatusInfo: @unchecked Sendable {}
extension ScanDeviceType: @unchecked Sendable {}
extension ScanConfigRequest: @unchecked Sendable {}
extension ScanForDevicesRequest: @unchecked Sendable {}
extension ConnectRequest: @unchecked Sendable {}
extension MotorDataRequest: @unchecked Sendable {}
extension DeviceInfo: @unchecked Sendable {}
extension DeviceEvent: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension BleStatusInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "BleStatusInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "status"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.status) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.status != 0 {
      try visitor.visitSingularInt32Field(value: self.status, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: BleStatusInfo, rhs: BleStatusInfo) -> Bool {
    if lhs.status != rhs.status {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension ScanDeviceType: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "ScanDeviceType"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "protocol"),
    2: .standard(proto: "device_type"),
    3: .standard(proto: "sub_type"),
    4: .same(proto: "vendor"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.`protocol`) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.deviceType) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.subType) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self.vendor) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.`protocol` != 0 {
      try visitor.visitSingularInt32Field(value: self.`protocol`, fieldNumber: 1)
    }
    if self.deviceType != 0 {
      try visitor.visitSingularInt32Field(value: self.deviceType, fieldNumber: 2)
    }
    if self.subType != 0 {
      try visitor.visitSingularInt32Field(value: self.subType, fieldNumber: 3)
    }
    if self.vendor != 0 {
      try visitor.visitSingularInt32Field(value: self.vendor, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: ScanDeviceType, rhs: ScanDeviceType) -> Bool {
    if lhs.`protocol` != rhs.`protocol` {return false}
    if lhs.deviceType != rhs.deviceType {return false}
    if lhs.subType != rhs.subType {return false}
    if lhs.vendor != rhs.vendor {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension ScanConfigRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "ScanConfigRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "mac"),
    2: .standard(proto: "scan_only"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.mac) }()
      case 2: try { try decoder.decodeSingularBoolField(value: &self.scanOnly) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.mac.isEmpty {
      try visitor.visitSingularStringField(value: self.mac, fieldNumber: 1)
    }
    if self.scanOnly != false {
      try visitor.visitSingularBoolField(value: self.scanOnly, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: ScanConfigRequest, rhs: ScanConfigRequest) -> Bool {
    if lhs.mac != rhs.mac {return false}
    if lhs.scanOnly != rhs.scanOnly {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension ScanForDevicesRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "ScanForDevicesRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "scan_device_types"),
    2: .standard(proto: "timeout_in_seconds"),
    3: .standard(proto: "scan_config"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.scanDeviceTypes) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.timeoutInSeconds) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._scanConfig) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.scanDeviceTypes.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.scanDeviceTypes, fieldNumber: 1)
    }
    if self.timeoutInSeconds != 0 {
      try visitor.visitSingularInt32Field(value: self.timeoutInSeconds, fieldNumber: 2)
    }
    try { if let v = self._scanConfig {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: ScanForDevicesRequest, rhs: ScanForDevicesRequest) -> Bool {
    if lhs.scanDeviceTypes != rhs.scanDeviceTypes {return false}
    if lhs.timeoutInSeconds != rhs.timeoutInSeconds {return false}
    if lhs._scanConfig != rhs._scanConfig {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension ConnectRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "ConnectRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "uuid"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.uuid) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.uuid.isEmpty {
      try visitor.visitSingularStringField(value: self.uuid, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: ConnectRequest, rhs: ConnectRequest) -> Bool {
    if lhs.uuid != rhs.uuid {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension MotorDataRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "MotorDataRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.value) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.value != 0 {
      try visitor.visitSingularInt32Field(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MotorDataRequest, rhs: MotorDataRequest) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension DeviceInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "DeviceInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .standard(proto: "firm_ware_version"),
    3: .same(proto: "uuid"),
    4: .standard(proto: "is_dual_motor"),
    5: .standard(proto: "is_dual_led"),
    6: .same(proto: "identifier"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.firmWareVersion) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.uuid) }()
      case 4: try { try decoder.decodeSingularBoolField(value: &self.isDualMotor) }()
      case 5: try { try decoder.decodeSingularBoolField(value: &self.isDualLed) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._identifier) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.firmWareVersion.isEmpty {
      try visitor.visitSingularStringField(value: self.firmWareVersion, fieldNumber: 2)
    }
    if !self.uuid.isEmpty {
      try visitor.visitSingularStringField(value: self.uuid, fieldNumber: 3)
    }
    if self.isDualMotor != false {
      try visitor.visitSingularBoolField(value: self.isDualMotor, fieldNumber: 4)
    }
    if self.isDualLed != false {
      try visitor.visitSingularBoolField(value: self.isDualLed, fieldNumber: 5)
    }
    try { if let v = self._identifier {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: DeviceInfo, rhs: DeviceInfo) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.firmWareVersion != rhs.firmWareVersion {return false}
    if lhs.uuid != rhs.uuid {return false}
    if lhs.isDualMotor != rhs.isDualMotor {return false}
    if lhs.isDualLed != rhs.isDualLed {return false}
    if lhs._identifier != rhs._identifier {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension DeviceEvent: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "DeviceEvent"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .standard(proto: "device_info"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.type) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._deviceInfo) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.type.isEmpty {
      try visitor.visitSingularStringField(value: self.type, fieldNumber: 1)
    }
    try { if let v = self._deviceInfo {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: DeviceEvent, rhs: DeviceEvent) -> Bool {
    if lhs.type != rhs.type {return false}
    if lhs._deviceInfo != rhs._deviceInfo {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
