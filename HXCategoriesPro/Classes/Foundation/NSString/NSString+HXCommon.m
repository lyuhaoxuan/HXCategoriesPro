//
//  NSString+HXCommon.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/30.
//

#import "NSString+HXCommon.h"
#import "NSNumber+HXCommon.h"
#import "NSData+HXCommon.h"
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
- (char)charValue {
    return self.numberValue.charValue;
}

- (unsigned char)unsignedCharValue {
    return self.numberValue.unsignedCharValue;
}

- (short)shortValue {
    return self.numberValue.shortValue;
}

- (unsigned short)unsignedShortValue {
    return self.numberValue.unsignedShortValue;
}

- (unsigned int)unsignedIntValue {
    return self.numberValue.unsignedIntValue;
}

- (long)longValue {
    return self.numberValue.longValue;
}

- (unsigned long)unsignedLongValue {
    return self.numberValue.unsignedLongValue;
}

- (unsigned long long)unsignedLongLongValue {
    return self.numberValue.unsignedLongLongValue;
}

- (NSUInteger)unsignedIntegerValue {
    return self.numberValue.unsignedIntegerValue;
}

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

+ (BOOL)isEmpty:(NSString *)string {
    return !string.isSafe;
}

+ (NSString *)stringFromFileSize:(NSUInteger)byteCount {
    return [self convertDataSize:byteCount diskMode:NO];
}

+ (NSString *)stringFromDiskSize:(NSUInteger)byteCount {
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

+ (NSString *)getRandomString {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
    for (int i = 0; i < kRandomLength; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    return randomString;
}

- (NSString *)stringByTrim {
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

- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

- (NSData *)dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (id)jsonValueDecoded {
    return [[self dataValue] jsonValueDecoded];
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

- (HXRelation)compareVesion:(NSString *)targetVersion {
    
    if ([NSString isEmpty:self] || [NSString isEmpty:targetVersion]) {
        return Unordered;
    }
    
    NSArray *intentArray = [targetVersion componentsSeparatedByString:@"."];
    NSArray *oldArray = [self componentsSeparatedByString:@"."];
    
    NSInteger count = oldArray.count >= intentArray.count ? oldArray.count : intentArray.count;
    for (int i = 0; i < count; i++) {
        NSString *str1 = [intentArray objectAtIndex:i];
        NSString *str2 = [oldArray objectAtIndex:i];
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

- (NSString *)handleURL {
    NSString *str = self;
    if (![NSString isEmpty:str]) {
        if ([str hasPrefix:@"http://"]) {
            str = [str stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        }
    }
    return str;
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

+ (NSString *)mimeTypeForFileAtPath:(NSString *)path {
    return [path MIMEType];
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

- (NSUInteger)caculateStringInt {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

@end
