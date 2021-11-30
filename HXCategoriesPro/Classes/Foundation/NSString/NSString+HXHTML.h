//
//  NSString+HXHTML.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXHTML)

/**
 使用Unicode 编码所有HTML实体
 
 - 例如: '&' 变成 '&amp;'. 这只会覆盖表格中的字符
 - A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
 - 如果你有一个 ASCII 或 非编码网页，请使用 stringByEscapingAsciiHTML
 
 */
- (nullable NSString *)stringByEscapingForHTML;

/**
 使用 ASCII 编码所有HTML实体
 
 - 例如: '&' 变成 '&amp;'
 - 如果你有一个 Unicode 编码 (UTF16 或 UTF8)，请使用 stringByEscapingForHTML

 */
- (nullable NSString *)stringByEscapingForAsciiHTML;

/**
 解码HTML实体
 
 - 例如: '&amp;' 变成 '&'
 - Handles &#32; and &#x32; cases as well
 
 */
- (nullable NSString *)stringByUnescapingFromHTML;

/**
 用<br />标签替换换行符。
 */
- (nullable NSString *)stringWithNewLinesAsBRs;

/**
 从字符串中删除 换行符 和 空格。
 */
- (nullable NSString *)stringByRemovingNewLinesAndWhitespace;

/**
 Wrap plain URLs in <a href="..." class="linkified">...</a>
 
 - Ignores URLs inside tags (any URL beginning with =")
 - HTTP & HTTPS schemes only
 - Only works in iOS 4+ as we use NSRegularExpression (returns self if not supported so be careful with NSMutableStrings)
 - Expression: (?<!=")\b((http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?)
 - Adapted from http://regexlib.com/REDetails.aspx?regexp_id=96

 */
- (nullable NSString *)stringByLinkifyingURLs;

/**
 DEPRECIATED - 请使用 stringByConvertingHTMLToPlainText
 */
- (nullable NSString *)stringByStrippingTags __attribute__((deprecated));

/**
 将 HTML 转换为纯文本
 */
- (nullable NSString *)stringByConvertingHTMLToPlainText;

@end

NS_ASSUME_NONNULL_END
