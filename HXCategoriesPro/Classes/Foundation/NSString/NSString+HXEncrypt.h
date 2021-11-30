//
//  NSString+HXEncrypt.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXEncrypt)

/// AES 加密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSString *)AES256EncryptWithKey:(NSString *)key iv:(nullable NSString *)iv;

/// AES 解密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSString *)AES256DecryptWithkey:(NSString *)key iv:(nullable NSString *)iv;

@end

NS_ASSUME_NONNULL_END
