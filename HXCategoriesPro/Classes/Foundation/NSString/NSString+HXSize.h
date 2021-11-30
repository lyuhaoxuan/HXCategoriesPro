//
//  NSString+HXSize.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//

#import <Foundation/Foundation.h>
#import "HXHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXSize)

/**
 计算文字的高度

 @param font    字体(默认为系统字体)
 @param width   约束宽度
 @return        高度
 */
- (CGFloat)heightWithFont:(nullable UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 计算文字的宽度

 @param font    字体(默认为系统字体)
 @param height  约束高度
 @return        宽度
 */
- (CGFloat)widthWithFont:(nullable UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 计算文字的大小

 @param font    字体(默认为系统字体)
 @param width   约束宽度
 @return        size
 */
- (CGSize)sizeWithFont:(nullable UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 计算文字的大小

 @param font    字体(默认为系统字体)
 @param height  约束高度
 @return        size
 */
- (CGSize)sizeWithFont:(nullable UIFont *)font constrainedToHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
