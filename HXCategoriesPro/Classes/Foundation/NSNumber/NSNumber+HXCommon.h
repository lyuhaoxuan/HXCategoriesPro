//
//  NSNumber+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/30.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (HXCommon)

/**
 NSString 转 NSNumber
 
 @param string      例如: @"12", @"12.345", @" -0xFF", @" .23e99 "...
 @return            如果发生错误, 则返回 nil
 */
+ (nullable NSNumber *)hx_numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
