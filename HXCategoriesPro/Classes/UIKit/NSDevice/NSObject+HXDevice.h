//
//  NSObject+HXDevice.h
//  ZDTalk
//
//  Created by 早道 on 2020/4/7.
//  Copyright © 2020 早道教育. All rights reserved.
//

#import "HXHeader.h"

#if MAC

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HXDevice)

/// 设备的 UUID
NSString * GetHardwareUUID(void);

/// 设备的序列号
NSString * GetHardwareSerialNumber(void);

@end

NS_ASSUME_NONNULL_END
#endif
