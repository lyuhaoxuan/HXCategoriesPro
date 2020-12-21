//
//  NSButton+HXCommon.m
//  ZDTalk
//
//  Created by 吕浩轩 on 2019/12/18.
//  Copyright © 2020 早道教育. All rights reserved.
//

#import "NSButton+HXCommon.h"

#if HX_MAC

#import "NSString+HXCommon.h"

@implementation NSButton (HXCommon)

- (void)setTitleTextColor:(NSColor *)newColor {
    
    if (!newColor || !self.attributedTitle) {
        return;
    }
    
    NSString *text = self.attributedTitle.string;
    if (!text || text.length == 0 || ![text isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSMutableAttributedString *newTitle = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedTitle];
    [newTitle addAttribute:NSForegroundColorAttributeName value:newColor range:NSMakeRange(0, newTitle.length)];
    
    self.attributedTitle = newTitle;
}

@end
#endif
