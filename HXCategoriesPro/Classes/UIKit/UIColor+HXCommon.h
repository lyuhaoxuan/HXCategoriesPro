//
//  UIColor+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/4.
//

#import "HXHeader.h"

NS_ASSUME_NONNULL_BEGIN

extern void HX_RGB2HSL(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *l);

extern void HX_HSL2RGB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void HX_RGB2HSB(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *v);

extern void HX_HSB2RGB(CGFloat h, CGFloat s, CGFloat v,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void HX_RGB2CMYK(CGFloat r, CGFloat g, CGFloat b,
                        CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k);

extern void HX_CMYK2RGB(CGFloat c, CGFloat m, CGFloat y, CGFloat k,
                        CGFloat *r, CGFloat *g, CGFloat *b);

extern void HX_HSB2HSL(CGFloat h, CGFloat s, CGFloat b,
                       CGFloat *hh, CGFloat *ss, CGFloat *ll);

extern void HX_HSL2HSB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *hh, CGFloat *ss, CGFloat *bb);

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

@property (nonatomic, readonly) CGFloat red;    ///< RGB颜色空间中的 红色 分量值。(0.0 ~ 1.0)
@property (nonatomic, readonly) CGFloat green;  ///< RGB颜色空间中的 绿色 分量值。(0.0 ~ 1.0)
@property (nonatomic, readonly) CGFloat blue;   ///< RGB颜色空间中的 蓝色 分量值。(0.0 ~ 1.0)

@property (nonatomic, readonly) CGFloat hue;        ///< HSB颜色空间中的 色调 分量值。(0.0 ~ 1.0)
@property (nonatomic, readonly) CGFloat saturation; ///< HSB颜色空间中的 饱和度 分量值。(0.0 ~ 1.0)
@property (nonatomic, readonly) CGFloat brightness; ///< HSB颜色空间中的 亮度 分量值。(0.0 ~ 1.0)

@property (nonatomic, readonly) CGFloat alpha;                          ///< alpha 值。(0.0 ~ 1.0)
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;      ///< 颜色空间
@property (nullable, nonatomic, readonly) NSString *colorSpaceString;   ///< 颜色空间，string 形式


#pragma mark - Create a UIColor Object

/// 使用指定的不透明度创建并返回颜色对象 和 HSL 颜色空间分量值。
/// @param hue          HSB颜色空间中的 色调 分量值。(0.0 ~ 1.0)
/// @param saturation   HSB颜色空间中的 饱和度 分量值。(0.0 ~ 1.0)
/// @param lightness    HSB颜色空间中的 亮度 分量值。(0.0 ~ 1.0)
/// @param alpha        alpha 值。(0.0 ~ 1.0)
+ (UIColor *)colorWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
                lightness:(CGFloat)lightness
                    alpha:(CGFloat)alpha;

/// 使用指定的不透明度创建并返回颜色对象和 CMYK 颜色空间分量值。
/// @param cyan     CMYK 颜色空间中颜色对象的 青色 分量。(0.0 ~ 1.0)
/// @param magenta  CMYK 颜色空间中颜色对象的 品红色 分量。(0.0 ~ 1.0)
/// @param yellow   CMYK 颜色空间中颜色对象的 黄色 分量。(0.0 ~ 1.0)
/// @param black    CMYK 颜色空间中颜色对象的 黑色 分量。(0.0 ~ 1.0)
/// @param alpha    alpha 值。(0.0 ~ 1.0)
+ (UIColor *)colorWithCyan:(CGFloat)cyan
                   magenta:(CGFloat)magenta
                    yellow:(CGFloat)yellow
                     black:(CGFloat)black
                     alpha:(CGFloat)alpha;

/// 使用十六进制 RGB 颜色值创建并返回颜色对象
/// @param rgbValue rgb 值，例如 0x66CCFF
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue;

/// 使用十六进制 RGBA 颜色值创建并返回颜色对象
/// @param rgbaValue rgb 值，例如 0x66CCFFFF
+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue;

/// 使用指定的'不透明度' 和 RGB 十六进制值创建并返回颜色对象。
/// @param rgbValue 0x66CCFF
/// @param alpha alpha 值。(0.0 ~ 1.0)
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/// 十六进制颜色字符串转 NSColor 或 UIColor
/// @discussion:
/// 有效格式: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
/// 这里 '#' 或 "0x" 不是必需的
/// alpha 默认: 1
/// 当解析中出现错误时, 它将返回nil
/// 例如: @"0xF0F", @"66ccff", @"#66CCFF88"
/// @param hexStr 十六进制颜色字符串
+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr;

/// 通过添加新颜色创建并返回颜色对象。
/// @param add          添加的颜色
/// @param blendMode    添加颜色混合模式
- (UIColor *)colorByAddColor:(UIColor *)add blendMode:(CGBlendMode)blendMode;

/// 通过更改组件创建并返回颜色对象。
/// @param hueDelta         指定为值的色调变化增量。(-1.0 ~ 1.0), 0 表示没有变化。
/// @param saturationDelta  饱和度变化增量指定为一个值。(-1.0 ~ 1.0), 0 表示没有变化。
/// @param brightnessDelta  指定为值的亮度变化增量。(-1.0 ~ 1.0), 0 表示没有变化。
/// @param alphaDelta       alpha 值。(-1.0 ~ 1.0), 0 表示没有变化。
- (UIColor *)colorByChangeHue:(CGFloat)hueDelta
                   saturation:(CGFloat)saturationDelta
                   brightness:(CGFloat)brightnessDelta
                        alpha:(CGFloat)alphaDelta;


#pragma mark - Get color's description

/// 以十六进制表示的 rgb 值。例子：0x66ccff
- (uint32_t)rgbValue;

/// 以十六进制表示的 rgba 值。例子：0x66ccffff
- (uint32_t)rgbaValue;

/// NSColor 或 UIColor 转十六进制颜色字符串 (RGB, 小写)。例如: @"0066cc"
- (nullable NSString *)hexString;

/// NSColor 或 UIColor 转十六进制颜色字符串 (RGBA, 小写)。例如: @"0066ccff"
- (nullable NSString *)hexStringWithAlpha;


#pragma mark - Retrieving Color Information

/// 返回构成 HSL 颜色空间中颜色的组件。
/// @param hue          返回 -> 色调 (0.0 ~ 1.0)
/// @param saturation   返回 -> 饱和度 (0.0 ~ 1.0)
/// @param lightness    返回 -> 亮度 (0.0 ~ 1.0)
/// @param alpha        返回 -> alpha (0.0 ~ 1.0)
/// @return 如果颜色可以转换为 YES，否则为 NO。
- (BOOL)getHue:(CGFloat *)hue
    saturation:(CGFloat *)saturation
     lightness:(CGFloat *)lightness
         alpha:(CGFloat *)alpha;

/// 返回构成 CMYK 颜色空间中颜色的组件。
/// @param cyan     返回 -> 青色 (0.0 ~ 1.0)
/// @param magenta  返回 -> 品红色 (0.0 ~ 1.0)
/// @param yellow   返回 -> 黄色 (0.0 ~ 1.0)
/// @param black    返回 -> 黑色 (0.0 ~ 1.0)
/// @param alpha    返回 -> alpha (0.0 ~ 1.0)
/// @return 如果颜色可以转换为 YES，否则为 NO。
- (BOOL)getCyan:(CGFloat *)cyan
        magenta:(CGFloat *)magenta
         yellow:(CGFloat *)yellow
          black:(CGFloat *)black
          alpha:(CGFloat *)alpha;


@end

NS_ASSUME_NONNULL_END
