//
//  NSString+HXCommon.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/30.
//

#import "NSString+HXCommon.h"
#import "NSNumber+HXCommon.h"
#import "NSArray+HXCommon.h"

#if TARGET_OS_IOS || TARGET_OS_WATCH || TARGET_OS_TV
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

// 生成字符串长度
#define kRandomLength 4

// 随机字符表
static const NSString *kRandomAlphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation NSString (HXCommon)

- (char)charValue { return self.numberValue.charValue; }
- (unsigned char)unsignedCharValue { return self.numberValue.unsignedCharValue; }
- (short)shortValue { return self.numberValue.shortValue; }
- (unsigned short)unsignedShortValue { return self.numberValue.unsignedShortValue; }
- (unsigned int)unsignedIntValue { return self.numberValue.unsignedIntValue; }
- (long)longValue { return self.numberValue.longValue; }
- (unsigned long)unsignedLongValue { return self.numberValue.unsignedLongValue; }
- (unsigned long long)unsignedLongLongValue { return self.numberValue.unsignedLongLongValue; }
- (NSUInteger)unsignedIntegerValue { return self.numberValue.unsignedIntegerValue; }

- (NSString *)MD5_string { return [self.dataValue MD5_string]; }
- (NSString *)SHA1_string { return [self.dataValue SHA1_string]; }
- (NSString *)SHA224_string { return [self.dataValue SHA224_string]; }
- (NSString *)SHA256_string { return [self.dataValue SHA256_string]; }
- (NSString *)SHA384_string { return [self.dataValue SHA384_string]; }
- (NSString *)SHA512_string { return [self.dataValue SHA512_string]; }

- (NSData *)MD5_data { return [self.dataValue MD5_data]; }
- (NSData *)SHA1_data { return [self.dataValue SHA1_data]; }
- (NSData *)SHA224_data { return [self.dataValue SHA224_data]; }
- (NSData *)SHA256_data { return [self.dataValue SHA256_data]; }
- (NSData *)SHA384_data { return [self.dataValue SHA384_data]; }
- (NSData *)SHA512_data { return [self.dataValue SHA512_data]; }

- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg key:(NSString *)key { return [self.dataValue hmacStringUsingAlg:alg key:key]; }
    
- (NSData *)hmacDataUsingAlg:(CCHmacAlgorithm)alg key:(NSData *)key { return [self.dataValue hmacDataUsingAlg:alg key:key]; }

- (nullable NSString *)crc32String { return [self.dataValue crc32String]; }

- (BOOL)isSafe {
    if (!self || ![self isKindOfClass:[NSString class]] || self.length == 0) {
        return NO;
    }
    
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isAllNum {
    unichar c;
    for (int i = 0; i < self.length; i++) {
        c = [self characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

- (NSString *)MIMEType {
    NSString *extension = self.pathExtension;
    if (!extension.isSafe) {
        if ([self hasPrefix:@"."]) {
            extension = [self substringFromIndex:1];
        } else {
            extension = self;
        }
    }
    
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"application/octet-stream";
    } else {
        return contentType;
    }
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSData *)hexData {
    NSString *hexStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
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

- (NSData *)dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)base64EncodedData {
    return [self.dataValue base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength | NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSData *)base64DecodedData {
    return [[NSData alloc] initWithBase64EncodedData:self.dataValue options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)base64EncodedString {
    return [self.dataValue base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength | NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSString *)base64DecodedString {
    return self.base64DecodedData.UTF8String;
}

- (id)jsonValueDecoded {
    return [[self dataValue] jsonValueDecoded];
}

- (nullable NSString *)AES256EncryptWithKey:(NSString *)key iv:(nullable NSString *)iv {
    NSData *encrypted = [self.dataValue AES256EncryptWithKey:key.dataValue iv:iv.dataValue];
    return encrypted.UTF8String;
}

- (nullable NSString *)AES256DecryptWithkey:(NSString *)key iv:(nullable NSString *)iv {
    NSData *encrypted = [self.dataValue AES256DecryptWithkey:key.dataValue iv:iv.dataValue];
    return encrypted.UTF8String;
}

- (NSString *)URLEncode {
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
            - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
            - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
            - parameter string: The string to be percent-escaped.
            - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
        return [self URLEntityEncode];
    }
}

- (NSString *)URLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
        return [self URLEntityDecode];
    }
}

- (NSString *)URLEntityEncode {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
#pragma clang diagnostic pop
    if (!encoded) {
        encoded = self;
    }
    return encoded;
}

- (NSString *)URLEntityDecode {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
#pragma clang diagnostic pop
    if (!decoded) {
        decoded = self;
    }
    return decoded;
}

+ (NSString *)UUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)timeStamp {
    return  [[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970] * 1000.] stringValue];
}

+ (NSString *)timeStampToString:(NSString *)timeStamp format:(NSString *)format {
    NSInteger createTime = timeStamp.integerValue;
    if (![format containsString:@"SSS"]) {
        createTime = createTime > (NSInteger)9999999999 ? createTime / 1000 : createTime;
    }
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:createTime];
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSComparisonResult)compareVesion:(NSString *)oldV newV:(NSString *)newV {
    
    if (!oldV.isSafe || !newV.isSafe) return 0;
    
    NSArray *oldArray = [oldV componentsSeparatedByString:@"."];
    NSArray *newArray = [newV componentsSeparatedByString:@"."];
    
    NSInteger count = oldArray.count >= newArray.count ? oldArray.count : newArray.count;
    for (int i = 0; i < count; i++) {
        NSString *str1 = [newArray objectAtIndex:i];
        NSString *str2 = [oldArray objectAtIndex:i];
        if (!str1) str1 = @"0";
        if (!str2) str2 = @"0";
        
        if (str1.integerValue > str2.integerValue) {
            return NSOrderedAscending;
        } else if (str1.integerValue < str2.integerValue) {
            return NSOrderedDescending;
        }
    }
    return NSOrderedSame;
}

+ (NSString *)stringFromFileSize:(NSUInteger)byteCount {
    return [self convertDataSize:byteCount diskMode:NO];
}

+ (NSString *)stringFromDiskSize:(NSUInteger)byteCount {
    return [self convertDataSize:byteCount diskMode:YES];
}

+ (NSString *)convertDataSize:(NSUInteger)dataSize diskMode:(BOOL)diskMode {
    
    if (dataSize == 0) return @"0B";
    
    double scale;
    
    if (diskMode == NO) {
        scale = 1024.f;
    } else {
        scale = 1000.f;
    }
    
    NSArray *sizeUnits = @[@"B",@"KB",@"MB",@"GB",@"TB",@"PB",@"EB",@"ZB",@"YB"];
    
    NSInteger count = sizeUnits.count;
    for (NSInteger i = 0; i < count; i++) {
        double sizeMin = pow(scale, i);
        double sizeMax = pow(scale, i + 1);
        if (dataSize >= sizeMin && dataSize < sizeMax) {
            return [NSString stringWithFormat:@"%.2f%@", dataSize / sizeMin, sizeUnits[i]];
        }
    }
    
    double size = pow(scale, count - 1);
    NSString *sizeUnit = [sizeUnits lastObject];
    return [NSString stringWithFormat:@"%.2f%@", dataSize / size, sizeUnit];
}

+ (NSString *)getRandomString {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
    for (int i = 0; i < kRandomLength; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    return randomString;
}

+ (NSString *)stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

@end
