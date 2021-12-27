//
//  MyModel.h
//  HXCategoriesPro_Example
//
//  Created by 吕浩轩 on 2021/11/26.
//  Copyright © 2021 吕浩轩. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyModel : NSObject

@property (nonatomic) NSInteger n_int;
@property (nonatomic) CGFloat n_float;
@property (nonatomic) BOOL n_bool;
@property (nonatomic, copy) NSString *string;
@property (nonatomic) NSNumber *number;
@property (nonatomic) NSValue *value;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSDictionary *dic;
@property (nonatomic) NSArray *arr;

@end

NS_ASSUME_NONNULL_END
