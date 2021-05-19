//
//  NSString+HXCommon.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/30.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSString+HXCommon.h"
#import "NSNumber+HXCommon.h"
#import "NSData+HXEncode.h"
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
- (char)hx_charValue {
    return self.hx_numberValue.charValue;
}

- (unsigned char)hx_unsignedCharValue {
    return self.hx_numberValue.unsignedCharValue;
}

- (short)hx_shortValue {
    return self.hx_numberValue.shortValue;
}

- (unsigned short)hx_unsignedShortValue {
    return self.hx_numberValue.unsignedShortValue;
}

- (unsigned int)hx_unsignedIntValue {
    return self.hx_numberValue.unsignedIntValue;
}

- (long)hx_longValue {
    return self.hx_numberValue.longValue;
}

- (unsigned long)hx_unsignedLongValue {
    return self.hx_numberValue.unsignedLongValue;
}

- (unsigned long long)hx_unsignedLongLongValue {
    return self.hx_numberValue.unsignedLongLongValue;
}

- (NSUInteger)hx_unsignedIntegerValue {
    return self.hx_numberValue.unsignedIntegerValue;
}

- (BOOL)hx_isSafe {
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

+ (BOOL)hx_isEmpty:(NSString *)string {
    return !string.hx_isSafe;
}

+ (NSString *)hx_stringFromFileSize:(NSUInteger)byteCount {
    return [self convertDataSize:byteCount diskMode:NO];
}

+ (NSString *)hx_stringFromDiskSize:(NSUInteger)byteCount {
    return [self convertDataSize:byteCount diskMode:YES];
}

+ (NSString *)convertDataSize:(NSUInteger)dataSize diskMode:(BOOL)diskMode {
    
    if (dataSize == 0) {
        return @"0 B";
    }
    
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
            return [NSString stringWithFormat:@"%.2f %@", dataSize / sizeMin, sizeUnits[i]];
        }
    }
    
    double size = pow(scale, count - 1);
    NSString *sizeUnit = [sizeUnits lastObject];
    return [NSString stringWithFormat:@"%.2f %@", dataSize / size, sizeUnit];
}

+ (NSString *)hx_getRandomString {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
    for (int i = 0; i < kRandomLength; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    return randomString;
}

- (NSString *)hx_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)removeLastSubString:(NSString *)string {
    NSString *result = self;
    if ([result hasSuffix:string]) {
        result = [result substringToIndex:self.length - string.length];
        result = [result removeLastSubString:string];
    }
    return result;
}

- (NSNumber *)hx_numberValue {
    return [NSNumber hx_numberWithString:self];
}

- (NSData *)hx_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSRange)hx_rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (id)hx_jsonValueDecoded {
    return [[self hx_dataValue] hx_jsonValueDecoded];
}

- (BOOL)hx_isAllNum {
    unichar c;
    for (int i = 0; i < self.length; i++) {
        c = [self characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

- (HXRelation)hx_compareVesion:(NSString *)targetVersion {
    
    if ([NSString hx_isEmpty:self] || [NSString hx_isEmpty:targetVersion]) {
        return Unordered;
    }
    
    NSArray *intentArray = [targetVersion componentsSeparatedByString:@"."];
    NSArray *oldArray = [self componentsSeparatedByString:@"."];
    
    NSInteger count = oldArray.count >= intentArray.count ? oldArray.count : intentArray.count;
    for (int i = 0; i < count; i++) {
        NSString *str1 = [intentArray hx_objectAtIndex:i];
        NSString *str2 = [oldArray hx_objectAtIndex:i];
        if (!str1) str1 = @"0";
        if (!str2) str2 = @"0";
        
        if (str1.integerValue > str2.integerValue) {
            return Less;
        } else if (str1.integerValue < str2.integerValue) {
            return Greater;
        }
    }
    return Equal;
}

- (NSString *)hx_handleURL {
    NSString *str = self;
    if (![NSString hx_isEmpty:str]) {
        if ([str hasPrefix:@"http://"]) {
            str = [str stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        }
    }
    return str;
}

+ (NSString *)hx_stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

+ (NSString *)mimeTypeForFileAtPath:(NSString *)path {
    return [path MIMEType];
}

- (NSString *)MIMEType {
    NSString *extension = self.pathExtension;
    if (!extension.hx_isSafe) {
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

- (NSUInteger)caculateStringInt {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

@end
