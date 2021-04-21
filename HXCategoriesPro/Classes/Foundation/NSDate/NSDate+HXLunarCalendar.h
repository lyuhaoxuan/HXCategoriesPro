//
//  NSDate+HXLunarCalendar.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/14.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HXLunarCalendar)

/**
 干支纪年
 */
@property (nonatomic, readonly) NSString *hx_HE_Y;

/**
 干支纪月
 */
@property (nonatomic, readonly) NSString *hx_HE_M;

/**
 干支纪日
 */
@property (nonatomic, readonly) NSString *hx_HE_D;

/**
 农历月
 */
@property (nonatomic, readonly) NSString *hx_L_M;

/**
 农历日
 */
@property (nonatomic, readonly) NSString *hx_L_D;

/**
 生肖
 */
@property (nonatomic, readonly) NSString *hx_zodiac;

@end

NS_ASSUME_NONNULL_END
