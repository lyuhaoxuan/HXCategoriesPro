//
//  NSObject+HXCopy.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HXCopy)

/**
 浅复制目标的所有属性

 @param instance 目标对象
 @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)hx_easyShallowCopy:(NSObject *)instance;

/**
 深复制目标的所有属性

 @param instance 目标对象
 @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)hx_easyDeepCopy:(NSObject *)instance;

@end

NS_ASSUME_NONNULL_END
