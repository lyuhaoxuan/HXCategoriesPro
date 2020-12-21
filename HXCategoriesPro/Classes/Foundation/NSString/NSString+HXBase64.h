//
//  NSString+HXBase64.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXBase64)

/**
 从base64编码的字符串返回一个NSString

 @param string base64编码的字符串
 @return NSString
 */
+ (nullable NSString *)hx_stringWithBase64EncodedString:(NSString *)string;

/**
 返回 Base64 编码的字符串与自动换行宽度

 @param wrapWidth 换行宽度
 @return NSString
 */
- (nullable NSString *)hx_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

/**
 返回 Base64 编码的 NSString
 */
- (nullable NSString *)hx_base64EncodedString;

/**
 返回 Base64 解码的 NSString
 */
- (nullable NSString *)hx_base64DecodedString;

/**
 返回 Base64 解码的 NSData
 */
- (nullable NSData *)hx_base64DecodedData;

@end

NS_ASSUME_NONNULL_END
