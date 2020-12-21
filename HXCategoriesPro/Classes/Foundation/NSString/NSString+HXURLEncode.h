//
//  NSString+HXURLEncode.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXURLEncode)

/**
 URL编码 string (UTF-8)

 @return 编码后的 string
 */
- (nullable NSString *)hx_urlEncode;

/**
 URL解码 string (UTF-8)

 @return 解码后的 string
 */
- (nullable NSString *)hx_urlDecode;

/**
URL编码 string (UTF-8)

@return 编码后的 string
*/
- (nullable NSString *)hx_encode;

/**
URL解码 string

@return 解码后的 string
*/
- (nullable NSString *)hx_decode;

@end

NS_ASSUME_NONNULL_END
