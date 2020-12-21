//
//  NSString+HXBase64.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSString+HXBase64.h"
#import "NSData+HXBase64.h"

@implementation NSString (HXBase64)
+ (NSString *)hx_stringWithBase64EncodedString:(NSString *)string {
    NSData *data = [NSData hx_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)hx_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data hx_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)hx_base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data hx_base64EncodedString];
}

- (NSString *)hx_base64DecodedString {
    return [NSString hx_stringWithBase64EncodedString:self];
}

- (NSData *)hx_base64DecodedData {
    return [NSData hx_dataWithBase64EncodedString:self];
}

@end
