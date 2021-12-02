//
//  NSData+HXCommon.h
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/11/29.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HXCommon)

#pragma mark - Hash

@property (nullable, readonly) NSString * MD5_string;       ///< MD5 NSString
@property (nullable, readonly) NSString * SHA1_string;      ///< SHA1 NSString
@property (nullable, readonly) NSString * SHA224_string;    ///< SHA224 NSString
@property (nullable, readonly) NSString * SHA256_string;    ///< SHA256 NSString
@property (nullable, readonly) NSString * SHA384_string;    ///< SHA384 NSString
@property (nullable, readonly) NSString * SHA512_string;    ///< SHA512 NSString

@property (nullable, readonly) NSData   * MD5_data;
@property (nullable, readonly) NSData   * SHA1_data;        ///< SHA1 NSData
@property (nullable, readonly) NSData   * SHA224_data;      ///< SHA224 NSData
@property (nullable, readonly) NSData   * SHA256_data;      ///< SHA256 NSData
@property (nullable, readonly) NSData   * SHA384_data;      ///< SHA384 NSData
@property (nullable, readonly) NSData   * SHA512_data;      ///< SHA512 NSData

- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg key:(NSString *)key;

- (NSData *)hmacDataUsingAlg:(CCHmacAlgorithm)alg key:(NSData *)key;

- (NSString *)crc32String;

- (uint32_t)crc32;


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

@property (nullable, readonly) NSString * UTF8String;            ///< NSData 转成 UTF8 字符串
@property (nullable, readonly) NSString * hexString;             ///< NSData 转成 十六进制
@property (nullable, readonly) NSData   * base64EncodedData;     ///< NSData 编码 Base64
@property (nullable, readonly) NSData   * base64DecodedData;     ///< NSData 解码 Base64
@property (nullable, readonly) NSString * base64EncodedString;   ///< NSData 编码 Base64
@property (nullable, readonly) NSString * base64DecodedString;   ///< NSData 解码 Base64
@property (nullable, readonly) id         jsonValueDecoded;      ///< 返回 NSDictionary 或 NSArray

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
