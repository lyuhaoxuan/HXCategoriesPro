//
//  NSDictionary+HXURL.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//

#import "NSDictionary+HXURL.h"
#import "NSArray+HXCommon.h"
#import "NSString+HXURLEncode.h"
#import "NSString+HXCommon.h"
#import "NSDictionary+HXCommon.h"

NSString * HXPercentEscapedStringFromString(NSString *string) {
    if ([string respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@";
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < string.length) {
            NSUInteger length = MIN(string.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            range = [string rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [string substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
        return [string URLEntityEncode];
    }
}

NSDictionary * HXDictionaryFromParametersString(NSString *parametersString) {

    NSArray *strings = [parametersString componentsSeparatedByString:@"?"];
    if (strings.count > 1) {
        parametersString = [strings lastObject];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *parameters = [parametersString componentsSeparatedByString:@"&"];
    for(NSString *parameter in parameters) {
        NSArray<NSString *> *contents = [parameter componentsSeparatedByString:@"="];
        if (contents.count > 2) {
            NSMutableArray *strings = [NSMutableArray array];
            [strings addObject:contents[0]];
            NSString *str = contents[1];
            for (int i = 2; i < contents.count; i++) {
                str = [str stringByAppendingString:@"="];
                str = [str stringByAppendingString:contents[i]];
            }
            [strings addObject:str];
            contents = strings;
        }
        
        if (contents.count == 2) {
            NSString *key = [contents objectAtIndex:0];
            NSString *value = [contents objectAtIndex:1];
            value = [value URLEntityDecode];
            if (key && value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    if (dict.allKeys == 0) {
        return nil;
    } else {
        return [NSDictionary dictionaryWithDictionary:dict];
    }
}

NSString * HXStringFromQueryParameters(NSDictionary *queryParameters, BOOL URLEncode) {
    
    if ([NSDictionary isEmpty:queryParameters]) return nil;
    
    NSMutableArray *parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [value stringValue];
        }
        
        NSString *part;
        if ([value isEqualToString:@""]) {
            part = [NSString stringWithFormat:@"%@", key];
        } else {
            if (URLEncode) {
                part = [NSString stringWithFormat:@"%@=%@",
                        HXPercentEscapedStringFromString(key),
                        HXPercentEscapedStringFromString(value)];
            } else {
                part = [NSString stringWithFormat:@"%@=%@", key, value];
            }
        }
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

NSString * HXURLEncode(NSString *URLString) {
    if ([NSString isEmpty:URLString]) return nil;
    
    NSString *h = [NSURL URLWithString:URLString].scheme;
    if (![NSString isEmpty:h]) {
        URLString = [URLString substringFromIndex:h.length + 2];
        h = [h stringByAppendingString:@":/"];
    }
    NSString *newString;
    NSString *lastPathComponent = [URLString lastPathComponent];
    NSString *pathExtension = [lastPathComponent pathExtension];
    if ([NSString isEmpty:pathExtension]) {
        NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
        URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    } else {
        NSString *deletingLastPathComponent = [URLString stringByDeletingLastPathComponent];
        NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
        deletingLastPathComponent = [deletingLastPathComponent stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        lastPathComponent = [lastPathComponent URLEntityEncode];

        newString = [deletingLastPathComponent stringByAppendingPathComponent:lastPathComponent];
    }
    
    if (![NSString isEmpty:h]) {
        newString = [h stringByAppendingString:newString];
    }
    
    return newString;
}

NSString * HXURLByAppendingQueryParameters(NSString *URLString, NSDictionary *parameters) {
    
    if ([NSString isEmpty:URLString]) return nil;
    if ([NSDictionary isEmpty:parameters]) return URLString;
        
    NSString *parametersString = HXStringFromQueryParameters(parameters, YES);
    if ([NSString isEmpty:parametersString]) {
        return [NSString stringWithFormat:@"%@", HXURLEncode(URLString)];
    } else {
        return [NSString stringWithFormat:@"%@?%@", HXURLEncode(URLString), parametersString];
    }
}

@implementation NSDictionary (HXURL)



@end
