//
//  NSButton+HXCommon.m
//  ZDTalk
//
//  Created by 吕浩轩 on 2019/12/18.
//  Copyright © 2020 早道教育. All rights reserved.
//

#import "NSButton+HXCommon.h"
#import "NSObject+HXCommon.h"

#if HX_MAC

#import "NSString+HXCommon.h"

@implementation NSButton (HXCommon)

- (void)setTitleColor:(NSColor *)titleColor {
    
    if (!titleColor || !self.attributedTitle) return;
    if (!self.attributedTitle.string.isSafe) return;

    NSMutableAttributedString *newTitle = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedTitle];
    [newTitle addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, newTitle.length)];
    
    self.attributedTitle = [newTitle copy];
}

@end

#endif
