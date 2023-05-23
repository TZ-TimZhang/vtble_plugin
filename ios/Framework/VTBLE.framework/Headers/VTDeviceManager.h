//
//  VTDeviceManager.h
//  VTBLE
//
//  Created by dev on 2022/7/26.
//

#import <Foundation/Foundation.h>
#import <VTBLE/VTDevice.h>
#import <VTBLE/VTModelIdentifier.h>

@class VTDeviceManager;

NS_ASSUME_NONNULL_BEGIN

@protocol VTDeviceManagerDelegate <NSObject>

@optional

/// Tells the delegate the device manager is currently scanning or not.
/// @param deviceManager The device manager that provides this information.
/// @param isScanning A Boolean value that indicates whether the device manager is currently scanning.
- (void)deviceManager:(VTDeviceManager *)deviceManager isScanning:(BOOL)isScanning;

/// Tells the delegate the device manager discovered a device while scanning for devices and asks the delegate whether or not connect the discovered device and stop scanning.
/// If the delegate does not implement this method, when the device manager discovers a device, it will connect the device and stop scanning.
/// @param deviceManager The device manager that provides the update.
/// @param device The discovered device.
/// @param connectAndStopScan Whether or not connect the discovered device and stop scanning. YES, the device manager will connect the device and stop scanning.
- (void)deviceManager:(VTDeviceManager *)deviceManager didDiscoverDevice:(VTDevice *)device connectAndStopScan:(BOOL *)connectAndStopScan;

/// Tells the delegate the scanning has timed out. If the device manager discovers a device within the specified interval,  connects the device and stops scanning, the method will not be invoked.
/// @param deviceManager The device manager that provides this information.
- (void)deviceManagerScanTimeout:(VTDeviceManager *)deviceManager;

/// Tells the delegate that the device manager connected to a device.
/// @param deviceManager The device manager that provides this information.
/// @param device The now-connected device.
- (void)deviceManager:(VTDeviceManager *)deviceManager didConnectDevice:(VTDevice *)device;

/// Tells the delegate the device manager failed to create a connection with a device.
/// @param deviceManager The device manager that provides this information.
/// @param device The device that failed to connect.
/// @param error The cause of the failure, or nil if no error occurred.
- (void)deviceManager:(VTDeviceManager *)deviceManager didFailToConnectDevice:(VTDevice *)device error:(nullable NSError *)error;

/// Tells the delegate that the central manager disconnected from a device.
/// @param deviceManager The device manager that provides this information.
/// @param device The now-disconnected device.
/// @param error The cause of the failure, or nil if no error occurred.
- (void)deviceManager:(VTDeviceManager *)deviceManager didDisconnectDevice:(VTDevice *)device error:(nullable NSError *)error;

@end

@interface VTDeviceManager : NSObject

/// The unique key of the customer.
@property (nonatomic, copy) NSString *key;

/// The delegate object that you want to receive device manager events.
@property (nonatomic, weak) id<VTDeviceManagerDelegate> delegate;

/// Whether or not the manager is currently scanning.
@property (nonatomic, assign, readonly) BOOL isScanning;

/// Starts scanning for devices.
/// @param modelIdentifiers A list of VTModelIdentifier objects representing the devices to scan for. If nil, all discovered devices will be returned.
/// @param timeout A timeout for scanning for devices, in seconds. A value of 0.0 indicates no timeout.
- (void)scanForDevicesWithModelIdentifiers:(NSArray<VTModelIdentifier *> *)modelIdentifiers timeout:(NSTimeInterval)timeout;

/// Stops scanning for devices.
- (void)stopScan;

/// Establishes a connection to device.
/// @param device The device to be connected.
- (void)connectDevice:(VTDevice *)device;

/// Cancels an active or pending connection to device.
/// @param device The device to which the manager is either trying to connect or has already connected.
- (void)disconnectDevice:(VTDevice *)device;

@end

NS_ASSUME_NONNULL_END
