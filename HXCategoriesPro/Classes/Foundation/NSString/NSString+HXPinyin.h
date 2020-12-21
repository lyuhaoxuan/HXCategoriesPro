//
//  NSString+HXPinyin.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXPinyin)

/** 汉字转带声调的拼音 */
- (NSString*)hx_pinyinWithPhoneticSymbol;

/** 汉字转普通拼音 */
- (NSString*)hx_pinyin;

/** 汉字转拼音数组 */
- (NSArray*)hx_pinyinArray;

/** 汉字转不带空格的拼音 */
- (NSString*)hx_pinyinWithoutBlank;

/** 提取拼音首字母数组 */
- (NSArray*)hx_pinyinInitialsArray;

/** 提取拼音首字母 */
- (NSString*)hx_pinyinInitialsString;

@end

NS_ASSUME_NONNULL_END
