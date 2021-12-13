//
//  HXCategories.h
//  LHX
//
//  Created by 吕浩轩 on 2018/6/14.
//

#ifndef HXCategories_h
#define HXCategories_h

#import "HXHeader.h"
#import "HXMacro.h"

/* Foundation */
#import "NSObject+HXCommon.h"
#import "NSObject+Model.h"
#import "NSData+HXCommon.h"
#import "NSString+HXCommon.h"
#import "NSString+HXHTML.h"
#import "NSString+HXPinyin.h"
#import "NSString+HXRegex.h"
#import "NSString+HXSize.h"
#import "NSNumber+HXCommon.h"
#import "NSTimer+HXCommon.h"
#import "NSDate+HXCommon.h"
#import "NSArray+HXCommon.h"
#import "NSDictionary+HXCommon.h"
#import "NSDictionary+HXURL.h"
#import "NSBezierPath+HXNSBezierPath.h"

/* UI */
#import "CALayer+HXCommon.h"
#import "UIView+HXCommon.h"
#import "UIColor+HXCommon.h"
#import "UIApplication+HXCommon.h"
#import "UITextField+HXCommon.h"
#import "NSButton+HXCommon.h"
#import "NSImage+HXCommon.h"

#if HX_IOS
#import "UIImage+HXCommon.h"
#import "UITableView+HXCommon.h"
#import "UIScrollView+HXCommon.h"
#import "UIBezierPath+HXCommon.h"
#endif

/// 设备信息
#import "HXDevice.h"

/// 线程安全容器
#import "HXThreadSafeArray.h"
#import "HXThreadSafeDictionary.h"

/// 计时器
#import "HXTimer.h"

#endif /* HXCategories_h */
