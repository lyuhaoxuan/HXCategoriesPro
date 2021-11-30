//
//  NSImage+HXCommon.m
//  ZDTalk
//
//  Created by 吕浩轩 on 2020/1/6.
//  Copyright © 2020 早道教育. All rights reserved.
//

#import "NSImage+HXCommon.h"

#if MAC

#import "NSArray+HXCommon.h"

@implementation NSImage (HXCommon)

/**
 * 保持四周一定区域像素不拉伸，将图像扩散到一定的大小
 */
- (NSImage *)stretchableImageWithSize:(NSSize)size edgeInsets:(NSEdgeInsets)insets
{
    void (^makeAreas)(NSRect, NSRect *, NSRect *, NSRect *, NSRect *, NSRect *, NSRect *, NSRect *, NSRect *, NSRect *) = ^(NSRect srcRect, NSRect *tl, NSRect *tc, NSRect *tr, NSRect *ml, NSRect *mc, NSRect *mr, NSRect *bl, NSRect *bc, NSRect *br) {
        CGFloat w = NSWidth(srcRect);//60
        CGFloat h = NSHeight(srcRect);//62
        
        CGFloat cw = w - insets.left - insets.right;//60 - 15 - 15 = 30
        CGFloat ch = h - insets.top - insets.bottom; //62 - 20 -20 = 22
        
        CGFloat x0 = NSMinX(srcRect);//0
        CGFloat x1 = x0 + insets.left;//15
        CGFloat x2 = NSMaxX(srcRect) - insets.right;//   60 - 15 = 45
        
        CGFloat y0 = NSMinY(srcRect);//0
        CGFloat y1 = y0 + insets.bottom;//20
        CGFloat y2 = NSMaxY(srcRect) - insets.top;//62-20=42
        
        *tl = NSMakeRect(x0, y2, insets.left, insets.top);
        *tc = NSMakeRect(x1, y2, cw, insets.top);
        *tr = NSMakeRect(x2, y2, insets.right, insets.top);
        
        *ml = NSMakeRect(x0, y1, insets.left, ch);
        *mc = NSMakeRect(x1, y1, cw, ch);
        *mr = NSMakeRect(x2, y1, insets.right, ch);
        
        *bl = NSMakeRect(x0, y0, insets.left, insets.bottom);
        *bc = NSMakeRect(x1, y0, cw, insets.bottom);
        *br = NSMakeRect(x2, y0, insets.right, insets.bottom);
    };
    
    NSRect rect = NSMakeRect(0, 0, size.width, size.height);
    
    // Source rects
    NSRect srcRect = (NSRect){NSZeroPoint, self.size};
    NSRect srcTopL, srcTopC, srcTopR, srcMidL, srcMidC, srcMidR, srcBotL, srcBotC, srcBotR;
    makeAreas(srcRect, &srcTopL, &srcTopC, &srcTopR, &srcMidL, &srcMidC, &srcMidR, &srcBotL, &srcBotC, &srcBotR);
    
    // Destinations rects
    NSRect dstTopL, dstTopC, dstTopR, dstMidL, dstMidC, dstMidR, dstBotL, dstBotC, dstBotR;
    makeAreas(rect, &dstTopL, &dstTopC, &dstTopR, &dstMidL, &dstMidC, &dstMidR, &dstBotL, &dstBotC, &dstBotR);
    
    NSRect srcRects[] = {srcTopL, srcTopC, srcTopR, srcMidL, srcMidC, srcMidR, srcBotL, srcBotC, srcBotR};
    NSRect dstRects[] = {dstTopL, dstTopC, dstTopR, dstMidL, dstMidC, dstMidR, dstBotL, dstBotC, dstBotR};
    NSMutableArray *partImgs = [NSMutableArray arrayWithCapacity:9];
    for (int i=0;i<9;i++)
    {
        NSRect aSrcRect = srcRects[i];
        NSRect aDstRect = dstRects[i];
        
        NSImage *partImg = [[NSImage alloc] initWithSize:aSrcRect.size];
        [partImg lockFocus];
        [self drawAtPoint:NSZeroPoint fromRect:aSrcRect operation:NSCompositingOperationSourceOver fraction:1.0];
        [partImg setSize:aDstRect.size];
        [partImg unlockFocus];
        [partImgs addObject:partImg];
    }
    
    // Draw
    NSImage *resultImg = [[NSImage alloc] initWithSize:rect.size];
    [resultImg lockFocus];
    NSDrawNinePartImage(rect,
                        [partImgs objectAtIndex:0],
                        [partImgs objectAtIndex:1],
                        [partImgs objectAtIndex:2],
                        [partImgs objectAtIndex:3],
                        [partImgs objectAtIndex:4],
                        [partImgs objectAtIndex:5],
                        [partImgs objectAtIndex:6],
                        [partImgs objectAtIndex:7],
                        [partImgs objectAtIndex:8],
                        NSCompositingOperationSourceOver, 1, NO);
    [resultImg unlockFocus];
    return resultImg;
}
 
 
/**
 * 保持leftWidth,rightWidth这左右一定区域不拉伸，将图片宽度拉伸到(leftWidth+middleWidth+rightWidth)
 */
- (NSImage *)stretchableImageWithLeftCapWidth:(float)leftWidth middleWidth:(float)middleWidth rightCapWidth:(float)rightWidth
{
    // Calculate the new images dimensions
    float imageWidth = leftWidth + middleWidth + rightWidth;
    float imageHeight = self.size.height;
    
    // Generate the left image
    NSRect rectLeft = NSMakeRect(0, 0, leftWidth, imageHeight);
    NSImage *imageLeft = [[NSImage alloc] initWithSize:rectLeft.size];
    if (imageLeft.size.width > 0) {
        [imageLeft lockFocus];
        [self drawInRect:rectLeft fromRect:rectLeft operation:NSCompositingOperationCopy fraction:1.0];
        [imageLeft unlockFocus];
    }
    
    // Generate the middle image
    NSRect rectMiddle = NSMakeRect(0, 0, middleWidth, imageHeight);
    NSImage *imageMiddle = [[NSImage alloc] initWithSize:rectMiddle.size];
    if (imageMiddle.size.width > 0) {
        [imageMiddle lockFocus];
        [self drawInRect:rectMiddle fromRect:NSMakeRect(leftWidth, 0, self.size.width-rightWidth-leftWidth,imageHeight) operation:NSCompositingOperationCopy fraction:1.0];
        [imageMiddle unlockFocus];
    }
    
    // Generate the right image
    NSRect rectRight = NSMakeRect(0, 0, rightWidth, imageHeight);
    NSImage *imageRight = [[NSImage alloc] initWithSize:rectRight.size];
    if (imageRight.size.width > 0) {
        [imageRight lockFocus];
        [self drawInRect:rectRight fromRect:NSMakeRect(self.size.width - rightWidth, 0, rightWidth, imageHeight) operation:NSCompositingOperationCopy fraction:1.0];
        [imageRight unlockFocus];
    }
    
    // Combine the images
    NSImage *newImage = [[NSImage alloc] initWithSize:NSMakeSize(imageWidth,  imageHeight)];
    if (newImage.size.width > 0) {
        [newImage lockFocus];
        NSDrawThreePartImage(NSMakeRect(0, 0, imageWidth, imageHeight), imageLeft, imageMiddle, imageRight, NO, NSCompositingOperationSourceOver, 1, NO);
        [newImage unlockFocus];
    }
    
    // Release the images and return the new image
    return newImage;
}

@end
#endif
