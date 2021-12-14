//
//  NSDictionary+HXURL.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Returns a percent-escaped string following RFC 3986 for a query string key or value.
 RFC 3986 states that the following characters are "reserved" characters.
 - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
 - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="

 In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
 query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
 should be percent-escaped in the query string.
 
 @param string The string to be percent-escaped.
 
 @return The percent-escaped string.
 */
FOUNDATION_EXPORT NSString * HXPercentEscapedStringFromString(NSString *string);

/**
 A helper method to generate encoded url query parameters for appending to the end of a URL.

 @param parameters A dictionary of key/values to be encoded.

 @return A url encoded query string
 */
FOUNDATION_EXPORT NSString * HXQueryStringFromParameters(NSDictionary *parameters);

@interface NSDictionary (HXURL)

/// NSDictionary 转义请求字符。
/// 例子：@{@"name":@"haoxuan", @"key":@"AB CD"} ==> name=haoxuan&key=AB%20CD
- (NSString *)queryStringFromParameters;

@end

NS_ASSUME_NONNULL_END
