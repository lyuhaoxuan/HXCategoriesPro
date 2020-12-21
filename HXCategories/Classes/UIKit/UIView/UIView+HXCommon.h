//
//  NSView+HXCommon.h
//  LHX
//
//  Created by 吕浩轩 on 2017/9/5.
//  Copyright © 2017年 LHX. All rights reserved.
//

#import "HXHeader.h"

@interface UIView (HXCommon)

@property (nonatomic) CGFloat left;    ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;     ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;   ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;  ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;   ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;  ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint origin;  ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;    ///< Shortcut for frame.size.

#if HX_MAC
/// 加载 xib 的 View
+ (instancetype)initFromXib;
#endif

/// 移除所有子视图
- (void)removeAllSubviews;

/// 在矩形内获取等比的 rect
/// @param size 图像 Size
/// @param rect 画布 Rect
CGRect RectWithAspectRatioInsideRect(CGSize size, CGRect rect);

@end
//#endif
