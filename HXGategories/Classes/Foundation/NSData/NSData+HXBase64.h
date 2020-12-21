//
//  NSData+HXBase64.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HXBase64)

/**
 Base64 转 NSData

 @param string 传入字符串
 @return 传入字符串 Base64 后的 NSData
 */
+ (nullable NSData *)hx_dataWithBase64EncodedString:(NSString *)string;

/**
 NSData 转 Base64

 @param wrapWidth 换行长度  76  64
 @return Base64 字符串
 */
- (nullable NSString *)hx_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

/**
 NSData 转 Base64

 @return Base64 字符串
 */
- (nullable NSString *)hx_base64EncodedString;

@end

NS_ASSUME_NONNULL_END
