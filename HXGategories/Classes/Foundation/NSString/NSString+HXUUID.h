//
//  NSString+HXUUID.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXUUID)

/**
 获取随机 UUI
 例如: @"D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 
 @return 随机 UUID
 */
+ (NSString *)hx_UUID;

/**
 毫秒时间戳
 例如: 1443066826371
 
 @return 毫秒时间戳
 */
+ (NSString *)hx_timeStamp;

/**
 时间戳转时间字符串
 例如: 1443066826371 -> 2015-09-24 11:53:46
 @param timeStamp 例：'1443066826371'
 @param format 例：'yyy-MM-dd HH:mm:ss'

 @return 时间字符串
*/
+ (NSString *)hx_timeStampToString:(NSString *)timeStamp format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
