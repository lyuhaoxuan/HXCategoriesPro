//
//  NSImage+HXCommon.h
//  ZDTalk
//
//  Created by 吕浩轩 on 2020/1/6.
//  Copyright © 2020 早道教育. All rights reserved.
//

#import "HXHeader.h"

#if HX_MAC

NS_ASSUME_NONNULL_BEGIN

@interface NSImage (HXCommon)

/**
The underlying Core Graphics image object. This will actually use `CGImageForProposedRect` with the image size.
 */
@property (nonatomic, readonly, nullable) CGImageRef CGImage;
/**
 The underlying Core Image data. This will actually use `bestRepresentationForRect` with the image size to find the `NSCIImageRep`.
 */
@property (nonatomic, readonly, nullable) CIImage *CIImage;
/**
 The scale factor of the image. This wil actually use `bestRepresentationForRect` with image size and pixel size to calculate the scale factor. If failed, use the default value 1.0. Should be greater than or equal to 1.0.
 */
@property (nonatomic, readonly) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
#endif
