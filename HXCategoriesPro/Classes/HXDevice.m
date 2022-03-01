//
//  HXDevice.m
//  Pods
//
//  Created by 吕浩轩 on 2021/12/8.
//

#import "HXDevice.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <mach/mach.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#import "NSString+HXCommon.h"
#import <SystemConfiguration/SCDynamicStoreCopySpecific.h>

#if HX_IOS
@implementation UIDevice (HXCommon)
#else
@implementation HXDevice
static id _device = nil;
+ (instancetype)currentDevice {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _device = [[super allocWithZone:NULL] init];
    });
    return _device;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone { return [self currentDevice]; }
- (id)copyWithZone:(NSZone *)zone { return self; }
- (id)mutableCopyWithZone:(NSZone *)zone { return self; }

- (NSString *)name {
    return CFBridgingRelease(SCDynamicStoreCopyComputerName(NULL, NULL));
}

- (NSString *)model {
    static id model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice")) ;
        if (service) {
            CFTypeRef typeRef = IORegistryEntryCreateCFProperty(service, CFSTR("target-type"), kCFAllocatorDefault, 0) ;
            if (typeRef) {
                model = CFBridgingRelease(typeRef);
                if ([model isKindOfClass:[NSData class]]) {
                    model = [[NSString alloc] initWithData:model encoding:NSMacOSRomanStringEncoding];
                    while ([(NSString *)model hasSuffix:@"\0"]) {
                        model = [(NSString *)model substringWithRange:NSMakeRange(0, [(NSString *)model length] - 1)];
                    }
                }
            }
            IOObjectRelease(service);
            service = 0;
        }
    });
    return model;
}

- (NSString *)systemName {
    static NSString * systemName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *dic = [self getSystemVersion];
        systemName = [dic valueForKey:@"ProductName"];
    });
    return systemName;
}

- (NSString *)systemVersion {
    static NSString * systemVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *dic = [self getSystemVersion];
        systemVersion = [dic valueForKey:@"ProductVersion"];
    });
    return systemVersion;
}

- (NSString *)systemBuildVersion {
    static NSString * systemBuildVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *dic = [self getSystemVersion];
        systemBuildVersion = [dic valueForKey:@"ProductBuildVersion"];
    });
    return systemBuildVersion;
}

- (NSString *)UUID {
    static NSString * UUID = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice")) ;
        if (service) {
            CFTypeRef typeRef = IORegistryEntryCreateCFProperty(service, CFSTR(kIOPlatformUUIDKey), kCFAllocatorDefault, 0) ;
            if (typeRef) {
                UUID = CFBridgingRelease(typeRef);
            }
            IOObjectRelease(service);
            service = 0;
        }
    });
    return UUID;
}

- (NSString *)serialNumber {
    static NSString * serialNumber = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice")) ;
        if (service) {
            CFTypeRef typeRef = IORegistryEntryCreateCFProperty(service, CFSTR(kIOPlatformSerialNumberKey), kCFAllocatorDefault, 0) ;
            if (typeRef) {
                serialNumber = CFBridgingRelease(typeRef);
            }
            IOObjectRelease(service);
            service = 0;
        }
    });
    return serialNumber;
}

- (NSDictionary *)getSystemVersion {
    static NSDictionary *systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
    });
    return systemVersion;
}

#endif

#if HX_IOS
- (BOOL)isPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    });
    return pad;
}

- (BOOL)isSimulator {
    static dispatch_once_t one;
    static BOOL simu;
    dispatch_once(&one, ^{
        simu = NSNotFound != [[self model] rangeOfString:@"Simulator"].location;
    });
    return simu;
}
#endif

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
- (BOOL)canMakePhoneCalls {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}
#endif

- (NSString *)ipAddressWithIfaName:(NSString *)name {
    NSString *ipAddress = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSInteger success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                NSString* ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString* address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
                if ([ifaName isEqualToString:name]) {
                    ipAddress = address;
                    break;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    return ipAddress;
}

- (NSString *)local_IP {
    return [self ipAddressWithIfaName:@"en0"];
}

- (NSString *)cellular_IP {
    return [self ipAddressWithIfaName:@"pdp_ip0"];
}

typedef struct {
    uint64_t en_in;
    uint64_t en_out;
    uint64_t pdp_ip_in;
    uint64_t pdp_ip_out;
    uint64_t awdl_in;
    uint64_t awdl_out;
} hx_net_interface_counter;


static uint64_t hx_net_counter_add(uint64_t counter, uint64_t bytes) {
    if (bytes < (counter % 0xFFFFFFFF)) {
        counter += 0xFFFFFFFF - (counter % 0xFFFFFFFF);
        counter += bytes;
    } else {
        counter = bytes;
    }
    return counter;
}

static uint64_t hx_net_counter_get_by_type(hx_net_interface_counter *counter, HXNetworkTrafficType type) {
    uint64_t bytes = 0;
    if (type & HXNetworkTrafficTypeWWANSent) bytes += counter->pdp_ip_out;
    if (type & HXNetworkTrafficTypeWWANReceived) bytes += counter->pdp_ip_in;
    if (type & HXNetworkTrafficTypeWIFISent) bytes += counter->en_out;
    if (type & HXNetworkTrafficTypeWIFIReceived) bytes += counter->en_in;
    if (type & HXNetworkTrafficTypeAWDLSent) bytes += counter->awdl_out;
    if (type & HXNetworkTrafficTypeAWDLReceived) bytes += counter->awdl_in;
    return bytes;
}

static hx_net_interface_counter hx_get_net_interface_counter() {
    static dispatch_semaphore_t lock;
    static NSMutableDictionary *sharedInCounters;
    static NSMutableDictionary *sharedOutCounters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInCounters = [NSMutableDictionary new];
        sharedOutCounters = [NSMutableDictionary new];
        lock = dispatch_semaphore_create(1);
    });
    
    hx_net_interface_counter counter = {0};
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    if (getifaddrs(&addrs) == 0) {
        cursor = addrs;
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
        while (cursor) {
            if (cursor->ifa_addr->sa_family == AF_LINK) {
                const struct if_data *data = cursor->ifa_data;
                NSString *name = cursor->ifa_name ? [NSString stringWithUTF8String:cursor->ifa_name] : nil;
                if (name) {
                    uint64_t counter_in = ((NSNumber *)sharedInCounters[name]).unsignedLongLongValue;
                    counter_in = hx_net_counter_add(counter_in, data->ifi_ibytes);
                    sharedInCounters[name] = @(counter_in);
                    
                    uint64_t counter_out = ((NSNumber *)sharedOutCounters[name]).unsignedLongLongValue;
                    counter_out = hx_net_counter_add(counter_out, data->ifi_obytes);
                    sharedOutCounters[name] = @(counter_out);
                    
                    if ([name hasPrefix:@"en"]) {
                        counter.en_in += counter_in;
                        counter.en_out += counter_out;
                    } else if ([name hasPrefix:@"awdl"]) {
                        counter.awdl_in += counter_in;
                        counter.awdl_out += counter_out;
                    } else if ([name hasPrefix:@"pdp_ip"]) {
                        counter.pdp_ip_in += counter_in;
                        counter.pdp_ip_out += counter_out;
                    }
                }
            }
            cursor = cursor->ifa_next;
        }
        dispatch_semaphore_signal(lock);
        freeifaddrs(addrs);
    }
    
    return counter;
}

- (uint64_t)getNetworkTrafficBytes:(HXNetworkTrafficType)types {
    hx_net_interface_counter counter = hx_get_net_interface_counter();
    return hx_net_counter_get_by_type(&counter, types);
}

- (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
#if HX_IOS
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
#else
        id ret = nil;
        io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice")) ;
        if (service) {
            CFTypeRef typeRef = IORegistryEntryCreateCFProperty(service, CFSTR("model"), kCFAllocatorDefault, 0) ;
            if (typeRef) {
                ret = CFBridgingRelease(typeRef);
                if ([ret isKindOfClass:[NSData class]]) {
                    ret = [[NSString alloc] initWithData:ret encoding:NSMacOSRomanStringEncoding];
                    while ([(NSString *)ret hasSuffix:@"\0"]) {
                        ret = [(NSString *)ret substringWithRange:NSMakeRange(0, [(NSString *)ret length] - 1)];
                    }
                }
            }
            IOObjectRelease(service);
            service = 0;
        }
        model = ret;
#endif
    });
    return model;
}

// http://theiphonewiki.com/wiki/Models
- (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self machineModel];
        if (!model) return;
        NSDictionary *dic = @{
            @"iPod1,1"    : @"iPod touch 1",
            @"iPod2,1"    : @"iPod touch 2",
            @"iPod3,1"    : @"iPod touch 3",
            @"iPod4,1"    : @"iPod touch 4",
            @"iPod5,1"    : @"iPod touch 5",
            @"iPod7,1"    : @"iPod touch 6",
            @"iPod9,1"    : @"iPod touch 7",
            
            @"iPhone1,1"  : @"iPhone 1G",
            @"iPhone1,2"  : @"iPhone 3G",
            @"iPhone2,1"  : @"iPhone 3GS",
            @"iPhone3,1"  : @"iPhone 4 (GSM)",
            @"iPhone3,2"  : @"iPhone 4",
            @"iPhone3,3"  : @"iPhone 4 (CDMA)",
            @"iPhone4,1"  : @"iPhone 4S",
            @"iPhone5,1"  : @"iPhone 5",
            @"iPhone5,2"  : @"iPhone 5",
            @"iPhone5,3"  : @"iPhone 5c",
            @"iPhone5,4"  : @"iPhone 5c",
            @"iPhone6,1"  : @"iPhone 5s",
            @"iPhone6,2"  : @"iPhone 5s",
            @"iPhone7,1"  : @"iPhone 6 Plus",
            @"iPhone7,2"  : @"iPhone 6",
            @"iPhone8,1"  : @"iPhone 6s",
            @"iPhone8,2"  : @"iPhone 6s Plus",
            @"iPhone8,4"  : @"iPhone SE",
            @"iPhone9,1"  : @"iPhone 7",
            @"iPhone9,2"  : @"iPhone 7 Plus",
            @"iPhone9,3"  : @"iPhone 7",
            @"iPhone9,4"  : @"iPhone 7 Plus",
            @"iPhone10,1" : @"iPhone 8",
            @"iPhone10,2" : @"iPhone 8 Plus",
            @"iPhone10,3" : @"iPhone X",
            @"iPhone10,4" : @"iPhone 8",
            @"iPhone10,5" : @"iPhone 8 Plus",
            @"iPhone10,6" : @"iPhone X",
            @"iPhone11,2" : @"iPhone XS",
            @"iPhone11,4" : @"iPhone XS Max",
            @"iPhone11,6" : @"iPhone XS Max",
            @"iPhone11,8" : @"iPhone XR",
            @"iPhone12,1" : @"iPhone 11",
            @"iPhone12,3" : @"iPhone 11 Pro",
            @"iPhone12,5" : @"iPhone 11 Pro Max",
            @"iPhone12,8" : @"iPhone SE 2",
            @"iPhone13,1" : @"iPhone 12 mini",
            @"iPhone13,2" : @"iPhone 12",
            @"iPhone13,3" : @"iPhone 12 Pro",
            @"iPhone13,4" : @"iPhone 12 Pro Max",
            @"iPhone14,2" : @"iPhone 13 Pro",
            @"iPhone14,3" : @"iPhone 13 Pro Max",
            @"iPhone14,4" : @"iPhone 13 mini",
            @"iPhone14,5" : @"iPhone 13",
            
            @"iPad1,1"    : @"iPad",
            @"iPad2,1"    : @"iPad 2",
            @"iPad2,2"    : @"iPad 2",
            @"iPad2,3"    : @"iPad 2",
            @"iPad2,4"    : @"iPad 2",
            @"iPad3,1"    : @"iPad 3",
            @"iPad3,2"    : @"iPad 3",
            @"iPad3,3"    : @"iPad 3",
            @"iPad3,4"    : @"iPad 4",
            @"iPad3,5"    : @"iPad 4",
            @"iPad3,6"    : @"iPad 4",
            @"iPad6,11"   : @"iPad 5",
            @"iPad6,12"   : @"iPad 5",
            @"iPad7,5"    : @"iPad 6",
            @"iPad7,6"    : @"iPad 6",
            @"iPad7,11"   : @"iPad 7",
            @"iPad7,12"   : @"iPad 7",
            @"iPad11,6"   : @"iPad 8",
            @"iPad11,7"   : @"iPad 8",
            @"iPad12,1"   : @"iPad 9",
            @"iPad12,2"   : @"iPad 9",
            
            @"iPad4,1"    : @"iPad Air",
            @"iPad4,2"    : @"iPad Air",
            @"iPad4,3"    : @"iPad Air",
            @"iPad5,3"    : @"iPad Air 2",
            @"iPad5,4"    : @"iPad Air 2",
            @"iPad11,3"   : @"iPad Air 3",
            @"iPad11,4"   : @"iPad Air 3",
            @"iPad13,1"   : @"iPad Air 4",
            @"iPad13,2"   : @"iPad Air 4",
            
            @"iPad6,7"    : @"iPad Pro (12.9-inch)",
            @"iPad6,8"    : @"iPad Pro (12.9-inch)",
            @"iPad6,3"    : @"iPad Pro (9.7-inch)",
            @"iPad6,4"    : @"iPad Pro (9.7-inch)",
            @"iPad7,1"    : @"iPad Pro (12.9-inch) 2",
            @"iPad7,2"    : @"iPad Pro (12.9-inch) 2",
            @"iPad7,3"    : @"iPad Pro (10.5-inch)",
            @"iPad7,4"    : @"iPad Pro (10.5-inch)",
            @"iPad8,1"    : @"iPad Pro (11-inch)",
            @"iPad8,2"    : @"iPad Pro (11-inch)",
            @"iPad8,3"    : @"iPad Pro (11-inch)",
            @"iPad8,4"    : @"iPad Pro (11-inch)",
            @"iPad8,5"    : @"iPad Pro (12.9-inch) 3",
            @"iPad8,6"    : @"iPad Pro (12.9-inch) 3",
            @"iPad8,7"    : @"iPad Pro (12.9-inch) 3",
            @"iPad8,8"    : @"iPad Pro (12.9-inch) 3",
            @"iPad8,9"    : @"iPad Pro (11-inch) 2",
            @"iPad8,10"   : @"iPad Pro (11-inch) 2",
            @"iPad8,11"   : @"iPad Pro (12.9-inch) 4",
            @"iPad8,12"   : @"iPad Pro (12.9-inch) 4",
            @"iPad13,4"   : @"iPad Pro (11-inch) 3",
            @"iPad13,5"   : @"iPad Pro (11-inch) 3",
            @"iPad13,6"   : @"iPad Pro (11-inch) 3",
            @"iPad13,7"   : @"iPad Pro (11-inch) 3",
            @"iPad13,8"   : @"iPad Pro (12.9-inch) 5",
            @"iPad13,9"   : @"iPad Pro (12.9-inch) 5",
            @"iPad13,10"  : @"iPad Pro (12.9-inch) 5",
            @"iPad13,11"  : @"iPad Pro (12.9-inch) 5",
            
            @"iPad2,5"    : @"iPad mini",
            @"iPad2,6"    : @"iPad mini",
            @"iPad2,7"    : @"iPad mini",
            @"iPad4,4"    : @"iPad mini 2",
            @"iPad4,5"    : @"iPad mini 2",
            @"iPad4,6"    : @"iPad mini 2",
            @"iPad4,7"    : @"iPad mini 3",
            @"iPad4,8"    : @"iPad mini 3",
            @"iPad4,9"    : @"iPad mini 3",
            @"iPad5,1"    : @"iPad mini 4",
            @"iPad5,2"    : @"iPad mini 4",
            @"iPad11,1"   : @"iPad mini 5",
            @"iPad11,2"   : @"iPad mini 5",
            @"iPad14,1"   : @"iPad mini 6",
            @"iPad14,2"   : @"iPad mini 6",
        
            @"i386"   : [[UIDevice currentDevice].name stringByAppendingFormat:@" (Simulator i386)"],
            @"x86_64" : [[UIDevice currentDevice].name stringByAppendingFormat:@" (Simulator x86_64)"]
        };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

- (NSDate *)systemUptime {
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}

- (int64_t)diskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceFree {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceUsed {
    int64_t total = self.diskSpace;
    int64_t free = self.diskSpaceFree;
    if (total < 0 || free < 0) return -1;
    int64_t used = total - free;
    if (used < 0) used = -1;
    return used;
}

- (int64_t)memoryTotal {
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

- (int64_t)memoryUsed {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count);
}

- (int64_t)memoryFree {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}

- (int64_t)memoryActive {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.active_count * page_size;
}

- (int64_t)memoryInactive {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.inactive_count * page_size;
}

- (int64_t)memoryWired {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.wire_count * page_size;
}

- (int64_t)memoryPurgable {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.purgeable_count * page_size;
}

- (NSUInteger)cpuCount {
    return [NSProcessInfo processInfo].activeProcessorCount;
}

- (float)cpuUsage {
    float cpu = 0;
    NSArray *cpus = [self cpuUsagePerProcessor];
    if (cpus.count == 0) return -1;
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}

- (NSArray *)cpuUsagePerProcessor {
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}

@end
