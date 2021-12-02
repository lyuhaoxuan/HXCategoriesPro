//
//  NSString+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/30.
//

#import <Foundation/Foundation.h>
#import "NSData+HXCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXCommon)

#pragma mark - 像 NSNumber 一样, 使用 NSString

@property (readonly) char               charValue;
@property (readonly) unsigned char      unsignedCharValue;
@property (readonly) short              shortValue;
@property (readonly) unsigned short     unsignedShortValue;
@property (readonly) unsigned int       unsignedIntValue;
@property (readonly) long               longValue;
@property (readonly) unsigned long      unsignedLongValue;
@property (readonly) unsigned long long unsignedLongLongValue;
@property (readonly) NSUInteger         unsignedIntegerValue;

@property (readonly) BOOL       isSafe;               ///< 判断字符串是否安全 包括: nil, null, @"", @"\n", @"  "等
@property (readonly) BOOL       isAllNum;             ///< 判断字符是否为纯数字
@property (readonly) NSRange    rangeOfAll;           ///< 返回 NSMakeRange(0, self.length)
@property (readonly) NSNumber * numberValue;          ///< 尝试解析这个字符串并返回一个NSNumber
@property (readonly) NSString * MIMEType;             ///< 获取 MIMEType (用于文件名或路径)
@property (readonly) NSString * stringByTrim;         ///< 去除头部和尾部的空白字符(空格和换行)


#pragma mark - Hash

@property (readonly) NSString * MD5_string;           ///< MD5 NSString
@property (readonly) NSString * SHA1_string;          ///< SHA1 NSString
@property (readonly) NSString * SHA224_string;        ///< SHA224 NSString
@property (readonly) NSString * SHA256_string;        ///< SHA256 NSString
@property (readonly) NSString * SHA384_string;        ///< SHA384 NSString
@property (readonly) NSString * SHA512_string;        ///< SHA512 NSString

@property (readonly) NSData   * MD5_data;             ///< MD5 NSData
@property (readonly) NSData   * SHA1_data;            ///< SHA1 NSData
@property (readonly) NSData   * SHA224_data;          ///< SHA224 NSData
@property (readonly) NSData   * SHA256_data;          ///< SHA256 NSData
@property (readonly) NSData   * SHA384_data;          ///< SHA384 NSData
@property (readonly) NSData   * SHA512_data;          ///< SHA512 NSData

/// 使用算法 和 key, 返回一个小写的 NSString
/// @param alg MD5/SHA1/SHA224/SHA256/SHA384/SHA512
/// @param key hmac key
- (nullable NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg key:(NSString *)key;

/// 使用算法 和 key, 返回 NSData
/// @param alg MD5/SHA1/SHA224/SHA256/SHA384/SHA512
/// @param key hmac key
- (nullable NSData *)hmacDataUsingAlg:(CCHmacAlgorithm)alg key:(NSData *)key;

/// crc32 hash
- (nullable NSString *)crc32String;


#pragma mark - Encrypt and Decrypt

/// AES 加密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSString *)AES256EncryptWithKey:(NSString *)key iv:(nullable NSString *)iv;

/// AES 解密
/// @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  IV
- (nullable NSString *)AES256DecryptWithkey:(NSString *)key iv:(nullable NSString *)iv;


#pragma mark - Encode and decode

@property (readonly) NSData   * hexData;              ///< 十六进制 NSString 转 NSData
@property (readonly) NSData   * dataValue;            ///< NSString 转 NSData (UTF-8)
@property (readonly) NSString * URLEncode;            ///< URL 编码
@property (readonly) NSString * URLDecode;            ///< URL 解码
@property (readonly) NSString * URLEntityEncode;      ///< URL 实体编码
@property (readonly) NSString * URLEntityDecode;      ///< URL 实体解码
@property (readonly) NSData   * base64EncodedData;    ///< NSData 编码 Base64
@property (readonly) NSData   * base64DecodedData;    ///< NSData 解码 Base64
@property (readonly) NSString * base64EncodedString;  ///< NSData 编码 Base64
@property (readonly) NSString * base64DecodedString;  ///< NSData 解码 Base64
@property (readonly) id         jsonValueDecoded;     ///< 将 NSString 解码成 NSDictionary/NSArray, 如果发生错, 返回 nil
                                                      /// 例如: NSString: @"{"name":"a","count":2}"  => NSDictionary: @{@"name":@"a",@"count":@2}


#pragma mark - Others

/// 获取随机 UUI
/// 例如: @"D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
+ (NSString *)UUID;

/// 毫秒时间戳
+ (NSString *)timeStamp;

/// 时间戳转时间字符串
/// 例如: 1443066826371 -> 2015-09-24T11:53:46Z
/// @param timeStamp '1443066826371'
/// @param format 'yyy-MM-dd'T'HH:mm:ssZ'
+ (NSString *)timeStampToString:(NSString *)timeStamp format:(NSString *)format;

/// 版本比较
/// @param oldV 1.0.0
/// @param newV 1.0.1
+ (NSComparisonResult)compareVesion:(NSString *)oldV newV:(NSString *)newV;

/// 以 1024 作单位转换数据大小为 KB MB GB 等格式
/// @param byteCount 大小
+ (NSString *)stringFromFileSize:(NSUInteger)byteCount;

/// 以 1000 作单位转换数据大小为 KB MB GB 等格式
/// @param byteCount 大小
+ (NSString *)stringFromDiskSize:(NSUInteger)byteCount;

/// 随机字符。（可更改参数：长4位，字符表'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'）
+ (NSString *)getRandomString;

/// 从 mainBundle 中创建 NSString (类似于 [UIImage imageNamed:])
/// @param name 在 mainBundle 中的文件名, 默认 txt
+ (nullable NSString *)stringNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
