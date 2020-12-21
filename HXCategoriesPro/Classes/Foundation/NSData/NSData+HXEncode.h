//
//  NSData+HXEncode.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HXEncode)

/**
 NSData 转成 UTF8 字符串
 */
- (NSString *)hx_UTF8String;

/**
 NSData 转成 十六进制数据
 */
- (NSString *)hx_hexString;

/**
 十六进制数据 转成 NSData

 @param hexString 十六进制数据
 */
+ (nullable NSData *)hx_dataWithHexString:(NSString *)hexString;

/**
 返回 NSDictionary 或 NSArray
 
 如果发生错误，则返回nil
 */
- (nullable id)hx_jsonValueDecoded;

@end

NS_ASSUME_NONNULL_END
