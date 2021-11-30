//
//  NSString+HXURLEncode.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXURLEncode)

/// URL 编码
- (nullable NSString *)URLEncode;

/// URL 解码
- (nullable NSString *)URLDecode;

/// URL 实体编码
- (nullable NSString *)URLEntityEncode;

/// URL 实体解码
- (nullable NSString *)URLEntityDecode;

@end

NS_ASSUME_NONNULL_END
