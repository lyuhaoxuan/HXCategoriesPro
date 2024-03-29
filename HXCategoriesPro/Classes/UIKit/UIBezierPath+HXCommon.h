//
//  UIBezierPath+HXCommon.h
//  Pods
//
//  Created by 吕浩轩 on 2021/12/10.
//

#import "HXHeader.h"

#if HX_IOS

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (HXCommon)

/**
 Creates and returns a new UIBezierPath object initialized with the text glyphs
 generated from the specified font.
 
 @discussion It doesnot support apple emoji. If you want get emoji image, try
 [UIImage imageWithEmoji:size:] in `UIImage(YYAdd)`.
 
 @param text The text to generate glyph path.
 @param font The font to generate glyph path.
 
 @return A new path object with the text and font, or nil if an error occurs.
 */
+ (nullable UIBezierPath *)bezierPathWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
#endif
