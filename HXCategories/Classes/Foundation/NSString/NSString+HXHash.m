//
//  NSString+HXHash.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSString+HXHash.h"
#import "NSData+HXHash.h"

@implementation NSString (HXHash)

- (NSString *)hx_MD2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_MD2String];
}

- (NSData *)hx_MD2Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_MD2Data];
}

- (NSString *)hx_MD4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_MD4String];
}

- (NSData *)hx_MD4Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_MD4Data];
}

- (NSString *)hx_MD5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_MD5String];
}

- (NSData *)hx_MD5Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_MD5Data];
}

- (NSString *)hx_SHA1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA1String];
}

- (NSData *)hx_SHA1Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA1Data];
}

- (NSString *)hx_SHA224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA224String];
}

- (NSData *)hx_SHA224Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA224Data];
}

- (NSString *)hx_SHA256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA256String];
}

- (NSData *)hx_SHA256Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA256Data];
}

- (NSString *)hx_SHA384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA384String];
}

- (NSData *)hx_SHA384Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA384Data];
}

- (NSString *)hx_SHA512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA512String];
}

- (NSData *)hx_SHA512Data {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_SHA512Data];
}

- (NSString *)hx_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_crc32String];
}

- (uint32_t)hx_crc32 {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_crc32];
}

- (NSString *)hx_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacMD5StringWithKey:key];
}

- (NSData *)hx_hmacMD5DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacMD5DataWithKey:key];
}

- (NSString *)hx_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA1StringWithKey:key];
}

- (NSData *)hx_hmacSHA1DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA1DataWithKey:key];
}

- (NSString *)hx_hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA224StringWithKey:key];
}

- (NSData *)hx_hmacSHA224DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA224DataWithKey:key];
}

- (NSString *)hx_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA256StringWithKey:key];
}

- (NSData *)hx_hmacSHA256DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA256DataWithKey:key];
}

- (NSString *)hx_hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA384StringWithKey:key];
}

- (NSData *)hx_hmacSHA384DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA384DataWithKey:key];
}

- (NSString *)hx_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA512StringWithKey:key];
}

- (NSData *)hx_hmacSHA512DataWithKey:(NSData *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hx_hmacSHA512DataWithKey:key];
}
@end
