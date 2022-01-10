//
//  UITextField+HXCommon.m
//  LHX
//
//  Created by 吕浩轩 on 2018/12/21.
//  Copyright © 2019 LHX. All rights reserved.
//

#import "UITextField+HXCommon.h"
#import "NSString+HXCommon.h"
#import "NSObject+HXCommon.h"

@implementation UITextField (HXCommon)

#if HX_MAC
- (NSString *)placeholderOrStringValue {
    NSString *string = self.stringValue;
    NSString *placeholderString = self.cell.accessibilityPlaceholderValue;
    if (string.isSafe) {
        return string;
    } else if (placeholderString.isSafe) {
        string = placeholderString;
    }
    return string;
}

- (BOOL)performKeyEquivalent:(NSEvent *)event {
    if (([event modifierFlags] & NSEventModifierFlagDeviceIndependentFlagsMask) == NSEventModifierFlagCommand) {
        if ([[event charactersIgnoringModifiers] isEqualToString:@"x"]) {
            return [NSApp sendAction:@selector(cut:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"c"]) {
            return [NSApp sendAction:@selector(copy:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"v"]) {
            return [NSApp sendAction:@selector(paste:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"a"]) {
            return [NSApp sendAction:@selector(selectAll:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"z"]) {
            [[[[self window] firstResponder] undoManager] undo];
            return YES;
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"Z"]) {
            [[[[self window] firstResponder] undoManager] redo];
            return YES;
        }
    }
    return [super performKeyEquivalent:event];
}

#else

- (void)selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}
#endif

@end
