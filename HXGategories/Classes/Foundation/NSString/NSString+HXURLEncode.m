//
//  NSString+HXURLEncode.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSString+HXURLEncode.h"
#import "NSDictionary+HXURL.h"
#import "NSString+HXCommon.h"

@implementation NSString (HXURLEncode)

- (NSString *)hx_urlEncode {
    if (![[self hx_urlDecode] isEqualToString:self]) {
        return self;
    }
    NSString *url = [self hx_urlDecode];
    
    NSArray *stringss = [self componentsSeparatedByString:@"#"];
    if (stringss.count >= 2) {
        NSString *su = @"";
        for (NSString *s in stringss) {
            NSString *ss = [s hx_urlEncode];
            su = [su stringByAppendingFormat:@"#%@", ss];
        }
        return [su substringWithRange:NSMakeRange(1, su.length - 1)];
    }
    
    NSArray *strings = [self componentsSeparatedByString:@"?"];
    NSDictionary *parameters;
    if (strings.count == 2) {
        parameters = HXDictionaryFromParametersString([strings lastObject]);
        url = HXURLByAppendingQueryParameters([strings firstObject], parameters);
        if ([NSString hx_isEmpty:url]) return self;
        return url;
    } else {
        NSString *lastPathComponent = [url lastPathComponent];
        NSString *pathExtension = [lastPathComponent pathExtension];
        if ([NSString hx_isEmpty:pathExtension]) {
            NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
            url = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        } else {
            NSString *deletingLastPathComponent = [url stringByDeletingLastPathComponent];
            NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
            deletingLastPathComponent = [deletingLastPathComponent stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
            lastPathComponent = [lastPathComponent hx_encode];

            url = [deletingLastPathComponent stringByAppendingPathComponent:lastPathComponent];
        }
        
        return url;
    }
}

- (NSString *)hx_urlDecode {
    NSString *decoded;
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        decoded = [self stringByRemovingPercentEncoding];
    }
    
    if (!decoded) {
        decoded = [self hx_decode];
    }
    
    return decoded;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (NSString *)hx_encode {
    NSString *encoded = (__bridge_transfer NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (__bridge CFStringRef)self,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
    if (!encoded) {
        encoded = self;
    }
    return encoded;
}

-(NSString *)hx_decode {
    NSString *decoded = (__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                            (__bridge CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8);
    if (!decoded) {
        decoded = self;
    }
    return decoded;
}
#pragma clang diagnostic pop

@end
