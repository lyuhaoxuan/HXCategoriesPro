//
//  NSBezierPath+HXNSBezierPath.h
//  LHX
//
//  Created by 吕浩轩 on 2017/5/20.
//  Copyright © 2017年 LHX. All rights reserved.
//

#import "HXHeader.h"

#if MAC

typedef NS_OPTIONS(NSUInteger, HXRectCorner) {
    HXRectCornerTopLeft     = 1 << 0,
    HXRectCornerTopRight    = 1 << 1,
    HXRectCornerBottomLeft  = 1 << 2,
    HXRectCornerBottomRight = 1 << 3,
    HXRectCornerAllCorners  = 0
};

@interface NSBezierPath (HXNSBezierPath)

@property (nonatomic) CGPathRef CGPath;
- (CGPathRef)CGPath NS_RETURNS_INNER_POINTER;

@property (nonatomic) BOOL usesEvenOddFillRule; // 默认是 NO. 当 YES, 单双数填充规则用于绘画, 剪裁, 点击, 测试

+ (NSBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
+ (NSBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(HXRectCorner)corners cornerRadii:(CGSize)cornerRadii;
+ (NSBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
+ (NSBezierPath *)bezierPathWithCGPath:(CGPathRef)CGPath;

- (void)addLineToPoint:(CGPoint)point;
- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

- (void)appendPath:(NSBezierPath *)bezierPath;
- (void)applyTransform:(CGAffineTransform)transform;

- (void)fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
- (void)strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
#endif
