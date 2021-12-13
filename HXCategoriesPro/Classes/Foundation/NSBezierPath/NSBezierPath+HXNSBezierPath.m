//
//  NSBezierPath+HXNSBezierPath.m
//  LHX
//
//  Created by 吕浩轩 on 2017/5/20.
//  Copyright © 2017年 LHX. All rights reserved.
//

#import "NSBezierPath+HXNSBezierPath.h"
#if HX_MAC
#import <objc/objc-runtime.h>

@implementation NSBezierPath (HXNSBezierPath)

@dynamic usesEvenOddFillRule;

+ (NSBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius
{
    return [NSBezierPath bezierPathWithRoundedRect:rect xRadius:cornerRadius yRadius:cornerRadius];
}

+ (NSBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(HXRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    const CGPoint topLeft = rect.origin;
    const CGPoint topRight = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    const CGPoint bottomRight = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    const CGPoint bottomLeft = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    
    if (corners & HXRectCornerTopLeft) {
        CGPathMoveToPoint(path, NULL, topLeft.x+cornerRadii.width, topLeft.y);
    } else {
        CGPathMoveToPoint(path, NULL, topLeft.x, topLeft.y);
    }
    
    if (corners & HXRectCornerTopRight) {
        CGPathAddLineToPoint(path, NULL, topRight.x-cornerRadii.width, topRight.y);
        CGPathAddCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y+cornerRadii.height, topRight.x, topRight.y+cornerRadii.height);
    } else {
        CGPathAddLineToPoint(path, NULL, topRight.x, topRight.y);
    }
    
    if (corners & HXRectCornerBottomRight) {
        CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y-cornerRadii.height);
        CGPathAddCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x-cornerRadii.width, bottomRight.y, bottomRight.x-cornerRadii.width, bottomRight.y);
    } else {
        CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y);
    }
    
    if (corners & HXRectCornerBottomLeft) {
        CGPathAddLineToPoint(path, NULL, bottomLeft.x+cornerRadii.width, bottomLeft.y);
        CGPathAddCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y-cornerRadii.height, bottomLeft.x, bottomLeft.y-cornerRadii.height);
    } else {
        CGPathAddLineToPoint(path, NULL, bottomLeft.x, bottomLeft.y);
    }
    
    if (corners & HXRectCornerTopLeft) {
        CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y+cornerRadii.height);
        CGPathAddCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x+cornerRadii.width, topLeft.y, topLeft.x+cornerRadii.width, topLeft.y);
    } else {
        CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y);
    }
    
    CGPathCloseSubpath(path);
    
    NSBezierPath *result = [NSBezierPath bezierPath];
    [result setCGPath:path];
    CGPathRelease(path);
    
    return result;
}


+ (NSBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    return path;
}


+ (NSBezierPath *)bezierPathWithCGPath:(CGPathRef)inPath
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path setCGPath:inPath];
    return path;
}

- (void)appendPath:(NSBezierPath *)bezierPath {
    [self appendBezierPath:bezierPath];
}

- (void)addLineToPoint:(CGPoint)point {
    [self lineToPoint:point];
}

- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2 {
    [self curveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
}

- (void)addQuadCurveToPoint:(CGPoint)QP2 controlPoint:(CGPoint)QP1
{
    // See http://fontforge.sourceforge.net/bezier.html
    
    CGPoint QP0 = [self currentPoint];
    CGPoint CP3 = QP2;
    
    CGPoint CP1 = CGPointMake(
                              //  QP0   +   2   / 3    * (QP1   - QP0  )
                              QP0.x + ((2.0 / 3.0) * (QP1.x - QP0.x)),
                              QP0.y + ((2.0 / 3.0) * (QP1.y - QP0.y))
                              );
    
    CGPoint CP2 = CGPointMake(
                              //  QP2   +  2   / 3    * (QP1   - QP2)
                              QP2.x + (2.0 / 3.0) * (QP1.x - QP2.x),
                              QP2.y + (2.0 / 3.0) * (QP1.y - QP2.y)
                              );
    
    [self curveToPoint:CP3 controlPoint1:CP1 controlPoint2:CP2];
}


- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
{
    [self appendBezierPathWithArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
}


- (void)applyTransform:(CGAffineTransform)transform
{
    NSAffineTransform *nsTransform = [NSAffineTransform transform];
    
    NSAffineTransformStruct transformStruct = {
        transform.a,  transform.b, transform.c, transform.d,
        transform.tx, transform.ty
    };
    
    [nsTransform setTransformStruct:transformStruct];
    [self transformUsingAffineTransform:nsTransform];
}


- (void)fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextSaveGState(context);
    
    CGContextSetBlendMode(context, blendMode);
    CGContextSetAlpha(context, alpha);
    
    [self fill];
    
    CGContextRestoreGState(context);
}


- (void)strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextSaveGState(context);
    
    CGContextSetBlendMode(context, blendMode);
    CGContextSetAlpha(context, alpha);
    
    [self stroke];
    
    CGContextRestoreGState(context);
}


static void sPathApplier(void *info, const CGPathElement *element)
{
    NSBezierPath *path = (__bridge NSBezierPath *)info;
    
    switch (element->type) {
        case kCGPathElementMoveToPoint:
            [path moveToPoint:element->points[0]];
            break;
            
        case kCGPathElementAddLineToPoint:
            [path lineToPoint:element->points[0]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint:
            [path addQuadCurveToPoint: element->points[1]
                         controlPoint: element->points[0]];
            
            break;
            
        case kCGPathElementAddCurveToPoint:
            [path curveToPoint: element->points[2]
                 controlPoint1: element->points[0]
                 controlPoint2: element->points[1]];
            
            break;
            
        case kCGPathElementCloseSubpath:
            [path closePath];
            break;
    }
}

- (void)setCGPath:(CGPathRef)CGPath {
    [self removeAllPoints];
    if (CGPathIsEmpty(CGPath)) return;
    
    CGPathApply(CGPath, (__bridge void *)self, sPathApplier);
}

- (CGPathRef)CGPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    NSPoint p[3];
    BOOL closed = NO;
    
    NSInteger elementCount = [self elementCount];
    for (NSInteger i = 0; i < elementCount; i++) {
        switch ([self elementAtIndex:i associatedPoints:p]) {
            case NSMoveToBezierPathElement:
                CGPathMoveToPoint(path, NULL, p[0].x, p[0].y);
                break;
                
            case NSLineToBezierPathElement:
                CGPathAddLineToPoint(path, NULL, p[0].x, p[0].y);
                closed = NO;
                break;
                
            case NSCurveToBezierPathElement:
                CGPathAddCurveToPoint(path, NULL, p[0].x, p[0].y, p[1].x, p[1].y, p[2].x, p[2].y);
                closed = NO;
                break;
                
            case NSClosePathBezierPathElement:
                CGPathCloseSubpath(path);
                closed = YES;
                break;
        }
    }
    
    if (elementCount > 0 && !closed)  CGPathCloseSubpath(path);
    
    CGPathRef immutablePath = CGPathCreateCopy(path);
    objc_setAssociatedObject(self, "CGPath", (__bridge id)immutablePath, OBJC_ASSOCIATION_RETAIN);
    CGPathRelease(immutablePath);
    
    CGPathRelease(path);
    
    return (__bridge CGPathRef)objc_getAssociatedObject(self, "CGPath");
}

- (void)setusesEvenOddFillRule:(BOOL)usesEvenOddFillRule {
    [self setWindingRule:usesEvenOddFillRule ? NSEvenOddWindingRule : NSNonZeroWindingRule];
}

- (BOOL)usesEvenOddFillRule
{
    return [self windingRule] == NSEvenOddWindingRule;
}

@end

#endif
