//
//  NSTextField+HXCommon.h
//  LHX
//
//  Created by 吕浩轩 on 2018/12/21.
//  Copyright © 2019 LHX. All rights reserved.
//

#import "HXHeader.h"

#if MAC

NS_ASSUME_NONNULL_BEGIN

@interface NSTextField (HXCommon)

- (NSString *)placeholderOrStringValue;

@end

NS_ASSUME_NONNULL_END
#endif
