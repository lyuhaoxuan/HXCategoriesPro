//
//  NSString+HXHash.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXHash)

/**
 MD2 NSData
 */
@property (nullable, readonly) NSData *hx_MD2Data;

/**
 MD2 NSString
 */
@property (nullable, readonly) NSString *hx_MD2String;

/**
 MD4 NSData
 */
@property (nullable, readonly) NSData *hx_MD4Data;

/**
 MD4 NSString
 */
@property (nullable, readonly) NSString *hx_MD4String;

/**
 MD5 NSData
 */
@property (nullable, readonly) NSData *hx_MD5Data;

/**
 MD5 NSString
 */
@property (nullable, readonly) NSString *hx_MD5String;

/**
 SHA1 NSData
 */
@property (nullable, readonly) NSData *hx_SHA1Data;

/**
 SHA1 NSString
 */
@property (nullable, readonly) NSString *hx_SHA1String;

/**
 SHA224 NSData
 */
@property (nullable, readonly) NSData *hx_SHA224Data;

/**
 SHA224 NSString
 */
@property (nullable, readonly) NSString *hx_SHA224String;

/**
 SHA256 NSData
 */
@property (nullable, readonly) NSData *hx_SHA256Data;

/**
 SHA256 NSString
 */
@property (nullable, readonly) NSString *hx_SHA256String;

/**
 SHA384 NSData
 */
@property (nullable, readonly) NSData *hx_SHA384Data;

/**
 SHA384 NSString
 */
@property (nullable, readonly) NSString *hx_SHA384String;

/**
 SHA512 NSData
 */
@property (nullable, readonly) NSData *hx_SHA512Data;

/**
 SHA512 NSString
 */
@property (nullable, readonly) NSString *hx_SHA512String;

/**
 使用算法 MD5 和 key, 返回一个小写的 NSString
 
 @param key  hmac key
 */
- (nullable NSString *)hx_hmacMD5StringWithKey:(NSString *)key;

/**
 使用算法 MD5 和 key, 返回 NSData
 
 @param key hmac key.
 */
- (nullable NSData *)hx_hmacMD5DataWithKey:(NSData *)key;

/**
 使用算法 SHA1 和 key, 返回一个小写的 NSString
 
 @param key hmac key.
 */
- (nullable NSString *)hx_hmacSHA1StringWithKey:(NSString *)key;

/**
 使用算法 SHA1 和 key, 返回 NSData
 
 @param key hmac key.
 */
- (nullable NSData *)hx_hmacSHA1DataWithKey:(NSData *)key;

/**
 使用算法 SHA224 和 key, 返回一个小写的 NSString
 
 @param key hmac key.
 */
- (nullable NSString *)hx_hmacSHA224StringWithKey:(NSString *)key;

/**
 使用算法 SHA224 和 key, 返回 NSData
 
 @param key hmac key.
 */
- (nullable NSData *)hx_hmacSHA224DataWithKey:(NSData *)key;

/**
 使用算法 SHA256 和 key, 返回一个小写的 NSString
 
 @param key hmac key.
 */
- (nullable NSString *)hx_hmacSHA256StringWithKey:(NSString *)key;

/**
 使用算法 SHA256 和 key, 返回 NSData
 
 @param key hmac key.
 */
- (nullable NSData *)hx_hmacSHA256DataWithKey:(NSData *)key;

/**
 使用算法 SHA384 和 key, 返回一个小写的 NSString
 
 @param key hmac key.
 */
- (nullable NSString *)hx_hmacSHA384StringWithKey:(NSString *)key;

/**
 使用算法 SHA384 和 key, 返回 NSData
 
 @param key hmac key.
 */
- (nullable NSData *)hx_hmacSHA384DataWithKey:(NSData *)key;

/**
 使用算法 SHA512 和 key, 返回一个小写的 NSString
 
 @param key hmac key.
 */
- (nullable NSString *)hx_hmacSHA512StringWithKey:(NSString *)key;

/**
 使用算法 SHA512 和 key, 返回 NSData
 
 @param key hmac key.
 */
- (nullable NSData *)hx_hmacSHA512DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (nullable NSString *)hx_crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)hx_crc32;

@end

NS_ASSUME_NONNULL_END
