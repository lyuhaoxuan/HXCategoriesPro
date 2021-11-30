//
//  NSString+HXHash.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXHash)

@property (nullable, readonly) NSData *SHA1Data;        ///< SHA1 NSData
@property (nullable, readonly) NSString *SHA1String;    ///< SHA1 NSString

@property (nullable, readonly) NSData *SHA224Data;      ///< SHA224 NSData
@property (nullable, readonly) NSString *SHA224String;  ///< SHA224 NSString

@property (nullable, readonly) NSData *SHA256Data;      ///< SHA256 NSData
@property (nullable, readonly) NSString *SHA256String;  ///< SHA256 NSString

@property (nullable, readonly) NSData *SHA384Data;      ///< SHA384 NSData
@property (nullable, readonly) NSString *SHA384String;  ///< SHA384 NSString

@property (nullable, readonly) NSData *SHA512Data;      ///< SHA512 NSData
@property (nullable, readonly) NSString *SHA512String;  ///< SHA512 NSString


/// 使用算法 SHA1 和 key, 返回一个小写的 NSString
/// @param key hmac key
- (nullable NSString *)hmacSHA1StringWithKey:(NSString *)key;

/// 使用算法 SHA1 和 key, 返回 NSData
/// @param key hmac key
- (nullable NSData *)hmacSHA1DataWithKey:(NSData *)key;

/// 使用算法 SHA224 和 key, 返回一个小写的 NSString
/// @param key hmac key
- (nullable NSString *)hmacSHA224StringWithKey:(NSString *)key;

/// 使用算法 SHA224 和 key, 返回 NSData
/// @param key hmac key
- (nullable NSData *)hmacSHA224DataWithKey:(NSData *)key;

/// 使用算法 SHA256 和 key, 返回一个小写的 NSString
/// @param key hmac key
- (nullable NSString *)hmacSHA256StringWithKey:(NSString *)key;

/// 使用算法 SHA256 和 key, 返回 NSData
/// @param key hmac key
- (nullable NSData *)hmacSHA256DataWithKey:(NSData *)key;

/// 使用算法 SHA384 和 key, 返回一个小写的 NSString
/// @param key hmac key
- (nullable NSString *)hmacSHA384StringWithKey:(NSString *)key;

/// 使用算法 SHA384 和 key, 返回 NSData
/// @param key hmac key
- (nullable NSData *)hmacSHA384DataWithKey:(NSData *)key;

/// 使用算法 SHA512 和 key, 返回一个小写的 NSString
/// @param key hmac key
- (nullable NSString *)hmacSHA512StringWithKey:(NSString *)key;

/// 使用算法 SHA512 和 key, 返回 NSData
/// @param key hmac key
- (nullable NSData *)hmacSHA512DataWithKey:(NSData *)key;

@end

NS_ASSUME_NONNULL_END
