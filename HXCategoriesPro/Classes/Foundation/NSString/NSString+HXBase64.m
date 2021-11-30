//
//  NSString+HXBase64.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import "NSString+HXBase64.h"
#import "NSData+HXCommon.h"

@implementation NSString (HXBase64)
+ (NSString *)stringWithBase64EncodedString:(NSString *)string {
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString {
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData {
    return [NSData dataWithBase64EncodedString:self];
}

@end
