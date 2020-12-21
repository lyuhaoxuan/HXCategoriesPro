//
//  NSTextField+HXCommon.m
//  LHX
//
//  Created by 吕浩轩 on 2018/12/21.
//  Copyright © 2019 LHX. All rights reserved.
//

#import "NSTextField+HXCommon.h"

#if HX_MAC
#import "NSString+HXCommon.h"

@implementation NSTextField (HXCommon)

- (NSString *)placeholderOrStringValue {
    NSString *string = self.stringValue;
    NSString *placeholderString = self.cell.accessibilityPlaceholderValue;
    if (![NSString hx_isEmpty:string]) {
        return string;
    } else if (![NSString hx_isEmpty:placeholderString]) {
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

@end
#endif
