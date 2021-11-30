//
//  NSObject+HXDevice.m
//  ZDTalk
//
//  Created by 早道 on 2020/4/7.
//  Copyright © 2020 早道教育. All rights reserved.
//

#import "NSObject+HXDevice.h"
#if MAC

@implementation NSObject (HXDevice)

NSString * GetHardwareUUID() {
    io_registry_entry_t ioRegistryRoot = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/");
    CFStringRef uuidCf = (CFStringRef) IORegistryEntryCreateCFProperty(ioRegistryRoot, CFSTR(kIOPlatformUUIDKey), kCFAllocatorDefault, 0);
    IOObjectRelease(ioRegistryRoot);
    NSString * uuid = (__bridge NSString *)uuidCf;
    CFRelease(uuidCf);
    return uuid;
}

NSString * GetHardwareSerialNumber() {
    NSString * ret = nil;
    io_service_t platformExpert ;
    platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice")) ;
    
    if (platformExpert)    {
        CFTypeRef uuidNumberAsCFString ;
        uuidNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0) ;
        if (uuidNumberAsCFString)    {
            ret = CFBridgingRelease(uuidNumberAsCFString);
        }
        IOObjectRelease(platformExpert); platformExpert = 0;
    }
    
    return ret;
}

@end
#endif
