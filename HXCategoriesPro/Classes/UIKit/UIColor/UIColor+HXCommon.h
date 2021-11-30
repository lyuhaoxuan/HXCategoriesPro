//
//  UIColor+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/4.
//

#import "HXHeader.h"

NS_ASSUME_NONNULL_BEGIN

/*
 十六进制颜色字符串转 NSColor 或 UIColor
 例如: HexColor(0xF0F), HexColor(66ccff), HexColor(#66CCFF88)
 
 有效格式: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 这里 '#' 或 "0x" 不是必需的
 */
#define HexColor(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]


/*
 随机颜色 NSColor 或 UIColor
 */
#define RandomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

/**
 颜色空间 更多: https://blog.ibireme.com/wp-content/uploads/2013/08/color-convert.png
 
 | Color space | Meaning                        |
 |-------------|--------------------------------|
 | RGB *       | Red, Green, Blue               |
 | HSB(HSV) *  | Hue, Saturation, Brightness    |
 | HSL         | Hue, Saturation, Lightness     |
 | CMYK        | Cyan, Magenta, Yellow, Black   |
 
 苹果使用RGB和HSB
 
 更多关于颜色:  https://blog.ibireme.com/2013/08/12/color-model/
 */

@interface UIColor (HXCommon)

/**
 RGB颜色空间中的 红色 分量值。
 这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat red;

/**
 RGB颜色空间中的 绿色 分量值。
 这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat green;

/**
 RGB颜色空间中的 蓝色 分量值。
 这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat blue;

/**
 HSB颜色空间中的 色调 分量值。
 这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat hue;

/**
 HSB颜色空间中的 饱和度 分量值。
 这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat saturation;

/**
 HSB颜色空间中的 亮度 分量值。
 这个属性的值是一个在`0.0`到`1.0`范围内的浮点数。
 */
@property (nonatomic, readonly) CGFloat brightness;

/**
 alpha 值
 该属性的值是范围 0.0 到 1.0 的浮点数
 */
@property (nonatomic, readonly) CGFloat alpha;

/**
 颜色空间
 */
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;

/**
 颜色空间，string 形式
 */
@property (nullable, nonatomic, readonly) NSString *colorSpaceString;




/**
 十六进制颜色字符串转 NSColor 或 UIColor
 
 @discussion:
 有效格式: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 这里 '#' 或 "0x" 不是必需的
 alpha 默认: 1
 当解析中出现错误时, 它将返回nil
 
 例如: @"0xF0F", @"66ccff", @"#66CCFF88"
 
 @param hexStr  十六进制颜色字符串
 
 @return        NSColor 或 UIColor
 */
+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr;

/**
 NSColor 或 UIColor 转十六进制颜色字符串 (RGB, 小写)
 例如: @"0066cc"
 
 当颜色空间不是 RGB 时, 它会返回nil
 
 @return 十六进制颜色字符串
 */
- (nullable NSString *)hexString;

/**
 NSColor 或 UIColor 转十六进制颜色字符串 (RGBA, 小写)
 Such as @"0066ccff".
 
 当颜色空间不是 RGBA 时, 它会返回nil
 
 @return 十六进制颜色字符串
 */
- (nullable NSString *)hexStringWithAlpha;


/**
 两个颜色模糊匹配相似，阈值：80

 @param color1 颜色 1
 @param color2 颜色 2
 @return 相似：返回 YES，反之返回 NO
 */
+ (BOOL)detectedColor1:(UIColor *)color1 color2:(UIColor *)color2;

@end

NS_ASSUME_NONNULL_END
