//
//  NSTimer+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (HXCommon)

/**
 暂停NSTimer
 */
- (void)hx_pauseTimer;

/**
 开始NSTimer
 */
- (void)hx_resumeTimer;

/**
 延迟开始NSTimer

 @param interval 延时时间
 */
- (void)hx_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
