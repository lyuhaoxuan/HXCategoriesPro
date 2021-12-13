//
//  NSImage+HXCommon.m
//  ZDTalk
//
//  Created by 吕浩轩 on 2020/1/6.
//  Copyright © 2020 早道教育. All rights reserved.
//

#import "NSImage+HXCommon.h"

#if HX_MAC

#import "NSArray+HXCommon.h"

@implementation NSImage (HXCommon)

- (nullable CGImageRef)CGImage {
    NSRect imageRect = NSMakeRect(0, 0, self.size.width, self.size.height);
    CGImageRef cgImage = [self CGImageForProposedRect:&imageRect context:nil hints:nil];
    return cgImage;
}

- (nullable CIImage *)CIImage {
    NSRect imageRect = NSMakeRect(0, 0, self.size.width, self.size.height);
    NSImageRep *imageRep = [self bestRepresentationForRect:imageRect context:nil hints:nil];
    if (![imageRep isKindOfClass:NSCIImageRep.class]) {
        return nil;
    }
    return ((NSCIImageRep *)imageRep).CIImage;
}

- (CGFloat)scale {
    CGFloat scale = 1;
    NSRect imageRect = NSMakeRect(0, 0, self.size.width, self.size.height);
    NSImageRep *imageRep = [self bestRepresentationForRect:imageRect context:nil hints:nil];
    CGFloat width = imageRep.size.width;
    CGFloat height = imageRep.size.height;
    CGFloat pixelWidth = (CGFloat)imageRep.pixelsWide;
    CGFloat pixelHeight = (CGFloat)imageRep.pixelsHigh;
    if (width > 0 && height > 0) {
        CGFloat widthScale = pixelWidth / width;
        CGFloat heightScale = pixelHeight / height;
        if (widthScale == heightScale && widthScale >= 1) {
            // Protect because there may be `NSImageRepMatchesDevice` (0)
            scale = widthScale;
        }
    }
    
    return scale;
}

@end

#endif
