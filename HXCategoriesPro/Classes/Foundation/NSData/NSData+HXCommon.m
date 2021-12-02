//
//  NSData+HXCommon.m
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/11/29.
//

#import "NSData+HXCommon.h"
#import <zconf.h>

@implementation NSData (HXCommon)

- (NSString *)MD5_string { return [self stringWithAlg:kCCHmacAlgMD5]; }
- (NSString *)SHA1_string { return [self stringWithAlg:kCCHmacAlgSHA1]; }
- (NSString *)SHA224_string { return [self stringWithAlg:kCCHmacAlgSHA224]; }
- (NSString *)SHA256_string { return [self stringWithAlg:kCCHmacAlgSHA256]; }
- (NSString *)SHA384_string { return [self stringWithAlg:kCCHmacAlgSHA384]; }
- (NSString *)SHA512_string { return [self stringWithAlg:kCCHmacAlgSHA512]; }

- (NSData *)MD5_data { return [self dataWithAlg:kCCHmacAlgMD5]; }
- (NSData *)SHA1_data { return [self dataWithAlg:kCCHmacAlgSHA1]; }
- (NSData *)SHA224_data { return [self dataWithAlg:kCCHmacAlgSHA224]; }
- (NSData *)SHA256_data { return [self dataWithAlg:kCCHmacAlgSHA256]; }
- (NSData *)SHA384_data { return [self dataWithAlg:kCCHmacAlgSHA384]; }
- (NSData *)SHA512_data { return [self dataWithAlg:kCCHmacAlgSHA512]; }

- (size_t)size_t_alg:(CCHmacAlgorithm)alg {
    switch (alg) {
        case kCCHmacAlgMD5:    return CC_MD5_DIGEST_LENGTH;
        case kCCHmacAlgSHA1:   return CC_SHA1_DIGEST_LENGTH;
        case kCCHmacAlgSHA224: return CC_SHA224_DIGEST_LENGTH;
        case kCCHmacAlgSHA256: return CC_SHA256_DIGEST_LENGTH;
        case kCCHmacAlgSHA384: return CC_SHA384_DIGEST_LENGTH;
        case kCCHmacAlgSHA512: return CC_SHA512_DIGEST_LENGTH;
        default:               return CC_SHA1_DIGEST_LENGTH;
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (NSString *)stringWithAlg:(CCHmacAlgorithm)alg {
    size_t size = [self size_t_alg:alg];
    unsigned char result[size];
    switch (alg) {
        case kCCHmacAlgMD5:    CC_MD5(self.bytes, (CC_LONG)self.length, result);    break;
        case kCCHmacAlgSHA1:   CC_SHA1(self.bytes, (CC_LONG)self.length, result);   break;
        case kCCHmacAlgSHA224: CC_SHA224(self.bytes, (CC_LONG)self.length, result); break;
        case kCCHmacAlgSHA256: CC_SHA256(self.bytes, (CC_LONG)self.length, result); break;
        case kCCHmacAlgSHA384: CC_SHA384(self.bytes, (CC_LONG)self.length, result); break;
        case kCCHmacAlgSHA512: CC_SHA512(self.bytes, (CC_LONG)self.length, result); break;
        default: return nil;
    }
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)dataWithAlg:(CCHmacAlgorithm)alg {
    size_t size = [self size_t_alg:alg];
    unsigned char result[size];
    switch (alg) {
        case kCCHmacAlgMD5:    CC_MD5(self.bytes, (CC_LONG)self.length, result);    break;
        case kCCHmacAlgSHA1:   CC_SHA1(self.bytes, (CC_LONG)self.length, result);   break;
        case kCCHmacAlgSHA224: CC_SHA224(self.bytes, (CC_LONG)self.length, result); break;
        case kCCHmacAlgSHA256: CC_SHA256(self.bytes, (CC_LONG)self.length, result); break;
        case kCCHmacAlgSHA384: CC_SHA384(self.bytes, (CC_LONG)self.length, result); break;
        case kCCHmacAlgSHA512: CC_SHA512(self.bytes, (CC_LONG)self.length, result); break;
        default: return nil;
    }
    return [NSData dataWithBytes:result length:size];
}
#pragma clang diagnostic pop

- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg key:(NSString *)key {
    size_t size = [self size_t_alg:alg];
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)hmacDataUsingAlg:(CCHmacAlgorithm)alg key:(NSData *)key {
    size_t size = [self size_t_alg:alg];
    unsigned char result[size];
    CCHmac(alg, [key bytes], key.length, self.bytes, self.length, result);
    return [NSData dataWithBytes:result length:size];
}

- (NSString *)crc32String {
    uLong result = crc32_z(0, self.bytes, (z_size_t)self.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}

- (uint32_t)crc32 {
    uLong result = crc32_z(0, self.bytes, (z_size_t)self.length);
    return (uint32_t)result;
}

- (NSData *)AES256EncryptWithKey:(NSData *)key iv:(NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

- (NSData *)AES256DecryptWithkey:(NSData *)key iv:(NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

- (NSString *)UTF8String {
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return @"";
}

- (NSString *)hexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

- (NSData *)base64EncodedData {
    return [self base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength | NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSData *)base64DecodedData {
    return [[NSData alloc] initWithBase64EncodedData:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)base64EncodedString {
    return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength | NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSString *)base64DecodedString {
    return self.base64DecodedData.UTF8String;
}

+ (NSData *)dataWithHexString:(NSString *)hexStr {
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    hexStr = [hexStr lowercaseString];
    NSUInteger len = hexStr.length;
    if (!len) return nil;
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [hexStr getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableData *result = [NSMutableData data];
    unsigned char bytes;
    char str[3] = { '\0', '\0', '\0' };
    int i;
    for (i = 0; i < len / 2; i++) {
        str[0] = buf[i * 2];
        str[1] = buf[i * 2 + 1];
        bytes = strtol(str, NULL, 16);
        [result appendBytes:&bytes length:1];
    }
    free(buf);
    return result;
}

- (id)jsonValueDecoded {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

+ (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (NSString *)APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

@end
