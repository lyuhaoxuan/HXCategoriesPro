//
//  NSString+HXHash.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import "NSString+HXHash.h"
#import "NSData+HXCommon.h"

@implementation NSString (HXHash)

- (NSString *)SHA1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA1String];
}

- (NSData *)SHA1Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA1Data];
}

- (NSString *)SHA224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA224String];
}

- (NSData *)SHA224Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA224Data];
}

- (NSString *)SHA256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA256String];
}

- (NSData *)SHA256Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA256Data];
}

- (NSString *)SHA384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA384String];
}

- (NSData *)SHA384Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA384Data];
}

- (NSString *)SHA512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA512String];
}

- (NSData *)SHA512Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA512Data];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA1StringWithKey:key];
}

- (NSData *)hmacSHA1DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA1DataWithKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA224StringWithKey:key];
}

- (NSData *)hmacSHA224DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA224DataWithKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA256StringWithKey:key];
}

- (NSData *)hmacSHA256DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA256DataWithKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA384StringWithKey:key];
}

- (NSData *)hmacSHA384DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA384DataWithKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA512StringWithKey:key];
}

- (NSData *)hmacSHA512DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA512DataWithKey:key];
}

@end
