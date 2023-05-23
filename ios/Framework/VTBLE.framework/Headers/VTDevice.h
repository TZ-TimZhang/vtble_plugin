//
//  VTDevice.h
//  VTBLE
//
//  Created by dev on 2022/7/28.
//

#import <Foundation/Foundation.h>
#import <VTBLE/VTModelIdentifier.h>
#import <VTBLE/VTAcceleration.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTDevice : NSObject

/// The name of the device.
@property (nonatomic, copy, readonly) NSString *name;

/// A string containing a formatted UUID, the value of this property represents the unique identifier of the device.
@property (nonatomic, copy, readonly) NSString *UUIDString;

/// The model identifier associated with the device.
@property (nonatomic, strong, readonly) VTModelIdentifier *modelIdentifier;

/// An string representing the current version of the firmware running on the device.
@property (nonatomic, copy, readonly) NSString *firmwareVersion;

/// Indicates whether the device is currently connected.
@property (nonatomic, assign, readonly) BOOL connected;

/// A block that the device calls when its services are ready. Then the device's methods,  eg, -setMotorVibrationStrength:, can be called.
@property (nonatomic, copy, nullable) void (^serviceReadyHandler)(void);

/// A block that receive acceleration values in G's (gravitational force).
@property (nonatomic, copy, nullable) void (^GSensorDataReceiver)(NSArray<VTAcceleration *> *data);

/// Sets vibration strength for the motor.
/// @param strength The vibration strength to set, specified as a value from 0 to 100. When it is 0, the device will stop vibrating.
- (void)setMotorVibrationStrength:(UInt8)strength;

/// Sets LED brightness
/// @param value The brightness to set, specified as a value from 0 to 100.
- (void)setLED:(UInt8)value;

/// Closes LED
- (void)closeLED;

/// Sets vibration strength for the motor and LED brightness.
/// @param strength The vibration strength to set, specified as a value from 0 to 100. When it is 0, the device will stop vibrating.
/// @param value The brightness to set, specified as a value from 0 to 100.
- (void)setMotorVibrationStrength:(UInt8)strength LED:(UInt8)value;

/// Sets vibration strength for the motor and LED brightness for the device with dual motors.
/// @param strength1 The vibration strength to set for motor 1, specified as a value from 0 to 100. When it is 0, the device will stop vibrating.
/// @param strength2 The vibration strength to set for motor 2, specified as a value from 0 to 100. When it is 0, the device will stop vibrating.
/// @param value The brightness to set, specified as a value from 0 to 100.
- (void)setMotor1VibrationStrength:(UInt8)strength1 motor2VibrationStrength:(UInt8)strength2 LED:(UInt8)value;

@end

NS_ASSUME_NONNULL_END
