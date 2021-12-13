//
//  NSDate+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HXCommon)

@property (readonly) NSCalendar *calendar;        ///< 日历
@property (readonly) NSTimeZone *timeZone;        ///< 时区
@property (readonly) NSInteger era;               ///< 纪元？
@property (readonly) NSInteger year;              ///< 年
@property (readonly) NSInteger month;             ///< 月 (1~12)
@property (readonly) NSInteger day;               ///< 日 (1~31)
@property (readonly) NSInteger hour;              ///< 时 (0~23)
@property (readonly) NSInteger minute;            ///< 分 (0~59)
@property (readonly) NSInteger second;            ///< 秒 (0~59)
@property (readonly) NSInteger nanosecond;        ///< 纳秒
@property (readonly) NSInteger weekday;           ///< 星期 (1~7)，1 是:星期日。注意：与 firstWeekday 无关
@property (readonly) NSInteger weekdayOrdinal;    ///< 当前月的第几个"星期几" (1~5)，例如：5月的第二个星期日是母亲节
@property (readonly) NSInteger weekOfMonth;       ///< 当前月的第几周 (1~5)
@property (readonly) NSInteger weekOfYear;        ///< 当前年的第几周 (1~53)
@property (readonly) NSInteger yearForWeekOfYear; ///< 当前周属于哪一年
@property (readonly) NSInteger quarter;           ///< 刻？季度?
@property (readonly) BOOL isLeapMonth;            ///< 闰月
@property (readonly) BOOL isLeapYear;             ///< 闰年
@property (readonly) BOOL isYesterday;            ///< 昨天
@property (readonly) BOOL isToday;                ///< 今天
@property (readonly) BOOL isTomorrow;             ///< 明天


/// NSDate 后移相应的年数
/// @param years 年数
- (nullable NSDate *)dateByAddingYears:(NSInteger)years;

/// NSDate 后移相应的月数
/// @param months 月数
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;

/// NSDate 后移相应的周数
/// @param weeks 周数
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;

/// NSDate 后移相应的天数
/// @param days 天数
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;

/// NSDate 后移相应的小时数
/// @param hours 小时数
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;

/// NSDate 后移相应的分钟数
/// @param minutes 分钟数
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;

/// NSDate 后移相应的年秒数
/// @param seconds 秒数
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;


#pragma mark - Date Format

/// 给定 ISO8601 格式化的字符串解析出 NSDate
/// @param string ISO8601 格式的时间字符串
///  ISO8601 format example:
///  2011-01-26T19:06:43Z
///  2011-01-11T11:11:11+0000
///  2010-07-09T16:13:30+12:00
+ (instancetype)dateWithISOFormatString:(NSString *)string;

/// 时间字符串自动解析出 NSDate <<< 竭尽所能的解析 >>>
/// @param string       时间字符（🌰 2011-01-26T19:06:43Z）
+ (instancetype)dateWithString:(NSString *)string;

/// 给定格式化的字符串解析出 NSDate
/// @param string   时间字符
/// @param format       格式化
+ (instancetype)dateWithString:(NSString *)string format:(NSString *)format;

/// 给定格式化的字符串解析出 NSDate
/// @param string   时间字符串
/// @param format       格式化
/// @param timeZone     时区
/// @param locale       语言环境
+ (instancetype)dateWithString:(NSString *)string
                        format:(NSString *)format
                      timeZone:(nullable NSTimeZone *)timeZone
                        locale:(nullable NSLocale *)locale;

/// 以 ISO8601 格式返回表示此 NSDate 的字符串
/// e.g. "2010-07-09T16:13:30Z"
- (nullable NSString *)ISOFormatString;

/// NSDate 的格式化字符串
/// see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
/// @param format   格式化 e.g. @"yyyy-MM-dd HH:mm:ss"
- (nullable NSString *)stringWithFormat:(NSString *)format;

/// NSDate 的格式化字符串
/// see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
/// @param format   格式化 e.g. @"yyyy-MM-dd HH:mm:ss"
/// @param timeZone 时区
/// @param locale   语言环境
- (nullable NSString *)stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;

@end

NS_ASSUME_NONNULL_END
