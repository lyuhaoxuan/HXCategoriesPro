//
//  NSTimer+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (HXCommon)

/**
 暂停NSTimer
 */
- (void)pauseTimer;

/**
 开始NSTimer
 */
- (void)resumeTimer;

/**
 延迟开始NSTimer

 @param interval 延时时间
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

/**
 Creates and returns a new NSTimer object and schedules it on the current run
 loop in the default mode.
 
 @discussion     After seconds seconds have elapsed, the timer fires,
                 sending the message aSelector to target.
 
 @param seconds  The number of seconds between firings of the timer. If seconds
                 is less than or equal to 0.0, this method chooses the
                 nonnegative value of 0.1 milliseconds instead.
 
 @param block    The block to invoke when the timer fires. The timer  maintains
                 a strong reference to the block until it (the timer) is invalidated.

 @param repeats  If YES, the timer will repeatedly reschedule itself until
                 invalidated. If NO, the timer will be invalidated after it fires.
 
 @return A new NSTimer object, configured according to the specified parameters.
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

/**
 Creates and returns a new NSTimer object initialized with the specified block.
 
 @discussion      You must add the new timer to a run loop, using addTimer:forMode:.
                  Then, after seconds have elapsed, the timer fires, invoking
                  block. (If the timer is configured to repeat, there is no need
                  to subsequently re-add the timer to the run loop.)
 
 @param seconds  The number of seconds between firings of the timer. If seconds
                 is less than or equal to 0.0, this method chooses the
                 nonnegative value of 0.1 milliseconds instead.
 
 @param block    The block to invoke when the timer fires. The timer instructs
                 the block to maintain a strong reference to its arguments.
 
 @param repeats  If YES, the timer will repeatedly reschedule itself until
                 invalidated. If NO, the timer will be invalidated after it fires.
 
 @return A new NSTimer object, configured according to the specified parameters.
 */
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
