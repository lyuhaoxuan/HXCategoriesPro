//
//  HXTimer.h
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// HXTimer is a thread-safe timer based on GCD. It has similar API with `NSTimer`.
// HXTimer object differ from NSTimer in a few ways:
//
// * It use GCD to produce timer tick, and won't be affected by runLoop.
// * It make a weak reference to the target, so it can avoid retain cycles.
// * It always fire on main thread.

@interface HXTimer : NSObject

@property (readonly) BOOL repeats;
@property (readonly) NSTimeInterval timeInterval;
@property (readonly, getter=isValid) BOOL valid;


+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval
                               target:(id)target
                             selector:(SEL)selector
                              repeats:(BOOL)repeats;

- (instancetype)initWithFireTime:(NSTimeInterval)start
                        interval:(NSTimeInterval)interval
                          target:(id)target
                        selector:(SEL)selector
                         repeats:(BOOL)repeats NS_DESIGNATED_INITIALIZER;

- (void)invalidate;

- (void)fire;

- (instancetype)init __attribute__((unavailable("Use the designated initializer to init.")));

@end

NS_ASSUME_NONNULL_END
