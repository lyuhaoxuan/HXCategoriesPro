//
//  NSDictionary+HXURL.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//

#import "NSDictionary+HXURL.h"
#import "NSArray+HXCommon.h"
#import "NSString+HXCommon.h"
#import "NSDictionary+HXCommon.h"

NSString * HXPercentEscapedStringFromString(NSString *string) {
    return [string URLEncode];
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
    
    if (!queryParameters.isSafe) return nil;
    
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
    if (!URLString.isSafe) return nil;
    
    NSString *h = [NSURL URLWithString:URLString].scheme;
    if (h.isSafe) {
        URLString = [URLString substringFromIndex:h.length + 2];
        h = [h stringByAppendingString:@":/"];
    }
    NSString *newString;
    NSString *lastPathComponent = [URLString lastPathComponent];
    NSString *pathExtension = [lastPathComponent pathExtension];
    if (!pathExtension.isSafe) {
        NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
        URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    } else {
        NSString *deletingLastPathComponent = [URLString stringByDeletingLastPathComponent];
        NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
        deletingLastPathComponent = [deletingLastPathComponent stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        lastPathComponent = [lastPathComponent URLEntityEncode];

        newString = [deletingLastPathComponent stringByAppendingPathComponent:lastPathComponent];
    }
    
    if (h.isSafe) {
        newString = [h stringByAppendingString:newString];
    }
    
    return newString;
}

NSString * HXURLByAppendingQueryParameters(NSString *URLString, NSDictionary *parameters) {
    
    if (!URLString.isSafe) return nil;
    if (!parameters.isSafe) return URLString;
        
    NSString *parametersString = HXStringFromQueryParameters(parameters, YES);
    if (!parametersString.isSafe) {
        return [NSString stringWithFormat:@"%@", HXURLEncode(URLString)];
    } else {
        return [NSString stringWithFormat:@"%@?%@", HXURLEncode(URLString), parametersString];
    }
}

@implementation NSDictionary (HXURL)



@end
