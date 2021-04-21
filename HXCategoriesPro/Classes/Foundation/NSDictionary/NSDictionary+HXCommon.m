//
//  NSDictionary+HXCommon.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSDictionary+HXCommon.h"
#import "NSData+HXEncode.h"

@implementation NSDictionary (HXCommon)

- (BOOL)hx_isSafe {
    if (!self || ![self isKindOfClass:[NSDictionary class]] || self.count == 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)hx_isEmpty:(NSDictionary *)dic {
    return !dic.hx_isSafe;
}

+ (NSDictionary *)hx_dictionaryWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([dictionary isKindOfClass:[NSDictionary class]]) return dictionary;
    return nil;
}

+ (NSDictionary *)hx_dictionaryWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self hx_dictionaryWithPlistData:data];
}

- (NSData *)hx_plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)hx_plistString {
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return xmlData.hx_UTF8String;
    return nil;
}

- (NSArray *)hx_allKeysSorted {
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)hx_allValuesSortedByKeys {
    NSArray *sortedKeys = [self hx_allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr;
}

- (BOOL)hx_containsObjectForKey:(id)key {
    if (!key) return NO;
    return self[key] != nil;
}

- (NSDictionary *)hx_entriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return dic;
}

- (NSString *)hx_jsonString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSString *)hx_jsonPrettyString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSJSONWritingOptions jsonOptions = NSJSONWritingPrettyPrinted;
        if (@available(macOS 10.13, iOS 11.0, watchos 4.0, tvos 11.0, *)) {
            jsonOptions |= NSJSONWritingSortedKeys;
        }
#if (__clang_major__ > 10)
        if (@available(macOS 10.14, iOS 12.0, watchos 5.0, tvos 12.0, *)) {
            jsonOptions |= NSJSONWritingFragmentsAllowed;
        }
        
        if (@available(macOS 10.15, iOS 13.0, watchos 6.0, tvos 13.0, *)) {
            jsonOptions |= NSJSONWritingWithoutEscapingSlashes;
        }
#endif
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:jsonOptions error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

/// Get a number value from 'id'.
static NSNumber *NSNumberFromID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) return nil;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) return @(YES);
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) return @(NO);
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) return nil;
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);
        } else {
            return @(((NSString *)value).longLongValue);
        }
    }
    return nil;
}

#define RETURN_VALUE(_type_)                                                     \
if (!key) return def;                                                            \
id value = self[key];                                                            \
if (!value || value == [NSNull null]) return def;                                \
if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value)._type_;   \
if ([value isKindOfClass:[NSString class]]) return NSNumberFromID(value)._type_; \
return def;

- (BOOL)hx_boolValueForKey:(NSString *)key default:(BOOL)def {
    RETURN_VALUE(boolValue);
}

- (char)hx_charValueForKey:(NSString *)key default:(char)def {
    RETURN_VALUE(charValue);
}

- (unsigned char)hx_unsignedCharValueForKey:(NSString *)key default:(unsigned char)def {
    RETURN_VALUE(unsignedCharValue);
}

- (short)hx_shortValueForKey:(NSString *)key default:(short)def {
    RETURN_VALUE(shortValue);
}

- (unsigned short)hx_unsignedShortValueForKey:(NSString *)key default:(unsigned short)def {
    RETURN_VALUE(unsignedShortValue);
}

- (int)hx_intValueForKey:(NSString *)key default:(int)def {
    RETURN_VALUE(intValue);
}

- (unsigned int)hx_unsignedIntValueForKey:(NSString *)key default:(unsigned int)def {
    RETURN_VALUE(unsignedIntValue);
}

- (long)hx_longValueForKey:(NSString *)key default:(long)def {
    RETURN_VALUE(longValue);
}

- (unsigned long)hx_unsignedLongValueForKey:(NSString *)key default:(unsigned long)def {
    RETURN_VALUE(unsignedLongValue);
}

- (long long)hx_longLongValueForKey:(NSString *)key default:(long long)def {
    RETURN_VALUE(longLongValue);
}

- (unsigned long long)hx_unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def {
    RETURN_VALUE(unsignedLongLongValue);
}

- (float)hx_floatValueForKey:(NSString *)key default:(float)def {
    RETURN_VALUE(floatValue);
}

- (double)hx_doubleValueForKey:(NSString *)key default:(double)def {
    RETURN_VALUE(doubleValue);
}

- (NSInteger)hx_integerValueForKey:(NSString *)key default:(NSInteger)def {
    RETURN_VALUE(integerValue);
}

- (NSUInteger)hx_unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def {
    RETURN_VALUE(unsignedIntegerValue);
}

- (NSNumber *)hx_numberValueForKey:(NSString *)key default:(NSNumber *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) return NSNumberFromID(value);
    return def;
}

- (NSString *)hx_stringValueForKey:(NSString *)key default:(NSString *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value).description;
    return def;
}

@end

@implementation NSMutableDictionary (HXCommon)

+ (NSMutableDictionary *)hx_dictionaryWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSMutableDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    if ([dictionary isKindOfClass:[NSMutableDictionary class]]) return dictionary;
    return nil;
}

+ (NSMutableDictionary *)hx_dictionaryWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self hx_dictionaryWithPlistData:data];
}

- (id)hx_popObjectForKey:(id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

- (NSDictionary *)hx_popEntriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dic[key] = value;
        }
    }
    return dic;
}
@end


