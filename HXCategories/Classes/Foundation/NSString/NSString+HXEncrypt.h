//
//  NSString+HXEncrypt.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXEncrypt)

/**
 AES加密

 @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 @param iv IV
 @return NSString
 */
- (nullable NSString *)hx_encryptedWithAESUsingKey:(NSString*)key andIV:(nullable NSData*)iv;

/**
 AES解密

 @param key 长度一般为16
 @param iv IV
 @return NSString
 */
- (nullable NSString *)hx_decryptedWithAESUsingKey:(NSString*)key andIV:(nullable NSData*)iv;
- (nullable NSString *)zd_decryptedWithAESUsingKey:(NSString*)key andIV:(nullable NSData*)iv;// 早道

/**
 DES加密

 @param key 长度一般为8
 @param iv IV
 @return NSString
 */
- (nullable NSString *)hx_encryptedWithDESUsingKey:(NSString*)key andIV:(nullable NSData*)iv;

/**
 DES解密

 @param key 长度一般为8
 @param iv IV
 @return NSString
 */
- (nullable NSString *)hx_decryptedWithDESUsingKey:(NSString*)key andIV:(nullable NSData*)iv;

/**
 3DES加密

 @param key 长度一般为24
 @param iv IV
 @return NSString
 */
- (nullable NSString *)hx_encryptedWith3DESUsingKey:(NSString*)key andIV:(nullable NSData*)iv;

/**
 3DES解密

 @param key 长度一般为24
 @param iv IV
 @return NSString
 */
- (nullable NSString *)hx_decryptedWith3DESUsingKey:(NSString*)key andIV:(nullable NSData*)iv;

@end

NS_ASSUME_NONNULL_END
