//
//  UITextField+HXCommon.h
//  LHX
//
//  Created by 吕浩轩 on 2018/12/21.
//  Copyright © 2019 LHX. All rights reserved.
//

#import "HXHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (HXCommon)

#if HX_MAC
- (NSString *)placeholderOrStringValue;
#else

/**
 Set all text selected.
 */
- (void)selectAllText;

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)setSelectedRange:(NSRange)range;
#endif

@end

NS_ASSUME_NONNULL_END
