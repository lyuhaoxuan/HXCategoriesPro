//
//  NSString+HXBase64.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXBase64)

/**
 从base64编码的字符串返回一个NSString

 @param string base64编码的字符串
 @return NSString
 */
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)string;

/**
 返回 Base64 编码的 NSString
 */
- (nullable NSString *)base64EncodedString;

/**
 返回 Base64 解码的 NSString
 */
- (nullable NSString *)base64DecodedString;

/**
 返回 Base64 解码的 NSData
 */
- (nullable NSData *)base64DecodedData;

@end

NS_ASSUME_NONNULL_END
