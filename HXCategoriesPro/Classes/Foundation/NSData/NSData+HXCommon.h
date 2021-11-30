//
//  NSData+HXCommon.h
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HXCommon)

#pragma mark - Hash

@property (nullable, readonly) NSString *SHA1String;
@property (nullable, readonly) NSData *SHA1Data;

@property (nullable, readonly) NSString *SHA224String;
@property (nullable, readonly) NSData *SHA224Data;

@property (nullable, readonly) NSString *SHA256String;
@property (nullable, readonly) NSData *SHA256Data;

@property (nullable, readonly) NSString *SHA384String;
@property (nullable, readonly) NSData *SHA384Data;

@property (nullable, readonly) NSString *SHA512String;
@property (nullable, readonly) NSData *SHA512Data;

/// 使用算法 SHA1 和 key, 返回一个小写的 NSString
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

/// 使用算法 SHA1 和 key, 返回 NSData
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

/// 使用算法 SHA224 和 key, 返回一个小写的 NSString
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

/// 使用算法 SHA224 和 key, 返回 NSData
- (NSData *)hmacSHA224DataWithKey:(NSData *)key;

/// 使用算法 SHA256 和 key, 返回一个小写的 NSString
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

/// 使用算法 SHA256 和 key, 返回 NSData
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

/// 使用算法 SHA384 和 key, 返回一个小写的 NSString
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

/// 使用算法 SHA384 和 key, 返回 NSData
- (NSData *)hmacSHA384DataWithKey:(NSData *)key;

/// 使用算法 SHA521 和 key, 返回一个小写的 NSString
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

/// 使用算法 SHA512 和 key, 返回 NSData
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;


#pragma mark - Encrypt and Decrypt

/// AES 加密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSData *)AES256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/// AES 解密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSData *)AES256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;


#pragma mark - Encode and decode

/// NSData 转成 UTF8 字符串
- (nullable NSString *)UTF8String;

/// NSData 转成 十六进制
- (nullable NSString *)hexString;

/// 十六进制 转成 NSData
/// @param hexString 数据
+ (nullable NSData *)dataWithHexString:(NSString *)hexString;

/// NSData 转 Base64
- (nullable NSString *)base64EncodedString;

/// Base64 转 NSData
/// @param base64EncodedString 数据
+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

/// 返回 NSDictionary 或 NSArray
- (nullable id)jsonValueDecoded;

#pragma mark - Others
/// 创建文件 Data
/// @param name 文件名字
+ (nullable NSData *)dataNamed:(NSString *)name;

/**
 将APNS NSData类型 Token 格式化成字符串

 @return 整理过后的字符串 Token
 */
- (NSString *)APNSToken;

@end

NS_ASSUME_NONNULL_END
