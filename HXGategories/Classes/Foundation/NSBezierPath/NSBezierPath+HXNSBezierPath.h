//
//  NSBezierPath+HXNSBezierPath.h
//  LHX
//
//  Created by 吕浩轩 on 2017/5/20.
//  Copyright © 2017年 LHX. All rights reserved.
//

#import "HXHeader.h"

#if HX_MAC

typedef NS_OPTIONS(NSUInteger, HXRectCorner) {
    HXRectCornerTopLeft     = 1 << 0,
    HXRectCornerTopRight    = 1 << 1,
    HXRectCornerBottomLeft  = 1 << 2,
    HXRectCornerBottomRight = 1 << 3,
    HXRectCornerAllCorners  = 0
};

@interface NSBezierPath (HXNSBezierPath)

@property (nonatomic) CGPathRef hx_CGPath;
- (CGPathRef)hx_CGPath NS_RETURNS_INNER_POINTER;

@property (nonatomic) BOOL hx_usesEvenOddFillRule; // 默认是 NO. 当 YES, 单双数填充规则用于绘画, 剪裁, 点击, 测试

+ (NSBezierPath *)hx_bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
+ (NSBezierPath *)hx_bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(HXRectCorner)corners cornerRadii:(CGSize)cornerRadii;
+ (NSBezierPath *)hx_bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
+ (NSBezierPath *)hx_bezierPathWithCGPath:(CGPathRef)CGPath;

- (void)hx_addLineToPoint:(CGPoint)point;
- (void)hx_addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
- (void)hx_addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
- (void)hx_addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

- (void)hx_appendPath:(NSBezierPath *)bezierPath;
- (void)hx_applyTransform:(CGAffineTransform)transform;

- (void)hx_fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
- (void)hx_strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
#endif
