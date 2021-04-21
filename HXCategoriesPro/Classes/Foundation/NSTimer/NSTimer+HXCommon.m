//
//  NSTimer+HXCommon.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSTimer+HXCommon.h"

@implementation NSTimer (HXCommon)

-(void)hx_pauseTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

-(void)hx_resumeTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)hx_resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
