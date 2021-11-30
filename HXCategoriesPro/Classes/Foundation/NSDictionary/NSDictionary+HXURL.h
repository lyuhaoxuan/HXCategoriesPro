//
//  NSDictionary+HXURL.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 将 url 的参数转换成 NSDictionary
 
 @param parametersString url的参数
 @return descriptionNSDictionary
 */
NSDictionary * _Nullable HXDictionaryFromParametersString(NSString * _Nullable parametersString);

/**
 这将从给定的NSDictionary创建一个新的查询参数字符串。
 
 例如，如果输入是@ {@“day”：@“Tuesday”，@“month”：@“January”}，输出
 字符串将是@“day=Tuesday＆month=January”。
 
 @param queryParameters     输入字典
 @return                    创建的参数字符串
 */
NSString * _Nullable HXStringFromQueryParameters(NSDictionary * _Nullable queryParameters, BOOL URLEncode);

/**
 通过添加给定的查询参数来创建新URL
 
 @param URLString           输入 URLString
 @param parameters          要添加的查询参数字典
 @return                    一个新的 URL
 */
NSString * _Nullable HXURLByAppendingQueryParameters(NSString * _Nullable URLString,
                                                   NSDictionary * _Nullable parameters);

/// URL编码
/// @param URLString URL
NSString * HXURLEncode(NSString *URLString);

@interface NSDictionary (HXURL)


@end

NS_ASSUME_NONNULL_END
