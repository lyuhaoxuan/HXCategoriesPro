//
//  NSString+HXURLEncode.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//

#import "NSString+HXURLEncode.h"
#import "NSDictionary+HXURL.h"
#import "NSString+HXCommon.h"

@implementation NSString (HXURLEncode)

- (nullable NSString *)URLEncode {
    NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

- (nullable NSString *)URLDecode {
    return [self stringByRemovingPercentEncoding];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (nullable NSString *)URLEntityEncode {
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

- (nullable NSString *)URLEntityDecode {
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
