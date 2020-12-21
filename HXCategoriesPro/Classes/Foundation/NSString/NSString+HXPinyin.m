//
//  NSString+HXPinyin.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSString+HXPinyin.h"

@implementation NSString (HXPinyin)

- (NSString*)hx_pinyinWithPhoneticSymbol {
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString*)hx_pinyin {
    NSMutableString *pinyin = [NSMutableString stringWithString:[self hx_pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSArray*)hx_pinyinArray {
    NSArray *array = [[self hx_pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

- (NSString*)hx_pinyinWithoutBlank {
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self hx_pinyinArray]) {
        [string appendString:str];
    }
    return string;
}

- (NSArray*)hx_pinyinInitialsArray {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self hx_pinyinArray]) {
        if ([str length] > 0) {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

- (NSString*)hx_pinyinInitialsString {
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self hx_pinyinArray]) {
        if ([str length] > 0) {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

@end
