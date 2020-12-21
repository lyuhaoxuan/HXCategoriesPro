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

@interface UIImage (HXCommon)

/// 保持四周一定区域像素不拉伸，将图像扩散到一定的大小
- (NSImage *)hx_stretchableImageWithSize:(NSSize)size edgeInsets:(NSEdgeInsets)insets;

/// 保持leftWidth,rightWidth这左右一定区域不拉伸，将图片宽度拉伸到(leftWidth+middleWidth+rightWidth)
- (NSImage *)hx_stretchableImageWithLeftCapWidth:(float)leftWidth middleWidth:(float)middleWidth rightCapWidth:(float)rightWidth;

@end

NS_ASSUME_NONNULL_END
#endif
