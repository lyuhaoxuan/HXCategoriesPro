//
//  NSString+HXUUID.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXUUID)

/**
 获取随机 UUI
 例如: @"D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 
 @return 随机 UUID
 */
+ (NSString *)UUID;

/**
 毫秒时间戳
 例如: 1443066826371
 
 @return 毫秒时间戳
 */
+ (NSString *)timeStamp;

/**
 时间戳转时间字符串
 例如: 1443066826371 -> 2015-09-24T11:53:46Z
 @param timeStamp 例：'1443066826371'
 @param format 例：'yyy-MM-dd'T'HH:mm:ssZ'

 @return 时间字符串
*/
+ (NSString *)timeStampToString:(NSString *)timeStamp format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
