//
//  NSString+HXPinyin.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXPinyin)

/// 汉字转带声调的拼音
- (NSString*)pinyinWithPhoneticSymbol;

/// 汉字转普通拼音
- (NSString*)pinyin;

/// 汉字转拼音数组
- (NSArray*)pinyinArray;

/// 汉字转不带空格的拼音
- (NSString*)pinyinWithoutBlank;

/// 提取拼音首字母数组
- (NSArray*)pinyinInitialsArray;

/// 提取拼音首字母
- (NSString*)pinyinInitialsString;

@end

NS_ASSUME_NONNULL_END
