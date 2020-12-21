//
//  NSData+HXAPNSToken.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HXAPNSToken)

/**
 将APNS NSData类型 Token 格式化成字符串

 @return 整理过后的字符串 Token
 */
- (NSString *)hx_APNSToken;
@end

NS_ASSUME_NONNULL_END
