//
//  HXDevice.h
//  Pods
//
//  Created by lyuhaoxuan on 2021/12/8.
//

#import "HXHeader.h"

NS_ASSUME_NONNULL_BEGIN

#if HX_IOS
@interface UIDevice (HXCommon)
#else
@interface HXDevice : NSObject

@property(class, nonatomic, readonly) HXDevice *currentDevice;

@property (nonatomic, readonly) NSString *name;               ///< e.g. @"lyuhaoxuan的MacBook Pro"
@property (nonatomic, readonly) NSString *model;              ///< e.g. @"Mac"
@property (nonatomic, readonly) NSString *systemName;         ///< e.g. @"macOS"
@property (nonatomic, readonly) NSString *systemVersion;      ///< e.g. @"12.0.1"
@property (nonatomic, readonly) NSString *systemBuildVersion; ///< e.g. @"21A559"

@property (nonatomic, readonly) NSString *UUID;               ///< 设备 UUID
@property (nonatomic, readonly) NSString *serialNumber;       ///< 序列号

#endif

#pragma mark - Device Information

#if HX_IOS
/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly) BOOL isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL isSimulator;
#endif

/// Wherher the device can make phone calls.
@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6" "MacBookPro15,1"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *machineModelName API_AVAILABLE(ios(2.0));

/// The System's startup time.
@property (nonatomic, readonly) NSDate *systemUptime;


#pragma mark - Network Information
///=============================================================================
/// @name Network Information
///=============================================================================

/// 局域网地址 IPv4  e.g. @"192.168.26.162"
@property (nullable, nonatomic, readonly) NSString *local_IP;

/// 蜂窝数据地址 IPv4 e.g. @"100.67.23.70"
@property (nullable, nonatomic, readonly) NSString *cellular_IP;


/**
 Network traffic type:
 
 WWAN: Wireless Wide Area Network.
       For example: 3G/4G.
 
 WIFI: Wi-Fi.
 
 AWDL: Apple Wireless Direct Link (peer-to-peer connection).
       For exmaple: AirDrop, AirPlay, GameKit.
 */
typedef NS_OPTIONS(NSUInteger, HXNetworkTrafficType) {
    HXNetworkTrafficTypeWWANSent     = 1 << 0,
    HXNetworkTrafficTypeWWANReceived = 1 << 1,
    HXNetworkTrafficTypeWIFISent     = 1 << 2,
    HXNetworkTrafficTypeWIFIReceived = 1 << 3,
    HXNetworkTrafficTypeAWDLSent     = 1 << 4,
    HXNetworkTrafficTypeAWDLReceived = 1 << 5,
    
    HXNetworkTrafficTypeWWAN = HXNetworkTrafficTypeWWANSent | HXNetworkTrafficTypeWWANReceived,
    HXNetworkTrafficTypeWIFI = HXNetworkTrafficTypeWIFISent | HXNetworkTrafficTypeWIFIReceived,
    HXNetworkTrafficTypeAWDL = HXNetworkTrafficTypeAWDLSent | HXNetworkTrafficTypeAWDLReceived,
    
    HXNetworkTrafficTypeALL = HXNetworkTrafficTypeWWAN |
                              HXNetworkTrafficTypeWIFI |
                              HXNetworkTrafficTypeAWDL,
};

/**
 Get device network traffic bytes.
 
 @discussion This is a counter since the device's last boot time.
 Usage:
 
     uint64_t bytes = [[UIDevice currentDevice] getNetworkTrafficBytes:HXNetworkTrafficTypeALL];
     NSTimeInterval time = CACurrentMediaTime();
     
     uint64_t bytesPerSecond = (bytes - _lastBytes) / (time - _lastTime);
     
     _lastBytes = bytes;
     _lastTime = time;
 
 
 @param types traffic types
 @return bytes counter.
 */
- (uint64_t)getNetworkTrafficBytes:(HXNetworkTrafficType)types;

#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t diskSpaceUsed;


#pragma mark - Memory Information
///=============================================================================
/// @name Memory Information
///=============================================================================

/// Total physical memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryUsed;

/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryFree;

/// Acvite memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryActive;

/// Inactive memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryPurgable;

#pragma mark - CPU Information
///=============================================================================
/// @name CPU Information
///=============================================================================

/// Avaliable CPU processor count.
@property (nonatomic, readonly) NSUInteger cpuCount;

/// Current CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float cpuUsage;

/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *cpuUsagePerProcessor;

@end

NS_ASSUME_NONNULL_END
