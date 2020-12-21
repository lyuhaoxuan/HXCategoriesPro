//
//  NSObject+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/30.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HXCommon)

/**
 获取属性的名字列表
 */
- (NSArray *)getPropertyNames;

/**
 通过属性的名字获取该属性的类型
 */
- (NSDictionary *)getPropertyClassesByName;
@end

NS_ASSUME_NONNULL_END
