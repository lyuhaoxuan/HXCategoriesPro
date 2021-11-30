//
//  NSString+HXEncrypt.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import "NSString+HXEncrypt.h"
#import "NSString+HXCommon.h"
#import "NSData+HXCommon.h"
#import "NSString+HXBase64.h"

@implementation NSString (HXEncrypt)

/// AES 加密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSString *)AES256EncryptWithKey:(NSString *)key iv:(nullable NSString *)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key.dataValue iv:iv.dataValue];
    return encrypted.UTF8String;
}

/// AES 解密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSString *)AES256DecryptWithkey:(NSString *)key iv:(nullable NSString *)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] AES256DecryptWithkey:key.dataValue iv:iv.dataValue];
    return encrypted.UTF8String;
}

@end
