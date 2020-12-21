//
//  NSDate+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/29.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HXCommon)

@property (nonatomic, readonly) NSInteger hx_year;              ///< Year component
@property (nonatomic, readonly) NSInteger hx_month;             ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger hx_day;               ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hx_hour;              ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger hx_minute;            ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger hx_second;            ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger hx_nanosecond;        ///< Nanosecond component
@property (nonatomic, readonly) NSInteger hx_weekday;           ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger hx_weekdayOrdinal;    ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger hx_weekOfMonth;       ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger hx_weekOfYear;        ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger hx_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger hx_quarter;           ///< Quarter component
@property (nonatomic, readonly) BOOL hx_isLeapMonth;            ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL hx_isLeapYear;             ///< Weather the year is leap year
@property (nonatomic, readonly) BOOL hx_isToday;                ///< Weather date is today (based on current locale)
@property (nonatomic, readonly) BOOL hx_isYesterday;            ///< Weather date is yesterday (based on current locale)

/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 
 @param years  Number of years to add.
 @return Date modified by the number of desired years.
 */
- (nullable NSDate *)hx_dateByAddingYears:(NSInteger)years;

/**
 Returns a date representing the receiver date shifted later by the provided number of months.
 
 @param months  Number of months to add.
 @return Date modified by the number of desired months.
 */
- (nullable NSDate *)hx_dateByAddingMonths:(NSInteger)months;

/**
 Returns a date representing the receiver date shifted later by the provided number of weeks.
 
 @param weeks  Number of weeks to add.
 @return Date modified by the number of desired weeks.
 */
- (nullable NSDate *)hx_dateByAddingWeeks:(NSInteger)weeks;

/**
 Returns a date representing the receiver date shifted later by the provided number of days.
 
 @param days  Number of days to add.
 @return Date modified by the number of desired days.
 */
- (nullable NSDate *)hx_dateByAddingDays:(NSInteger)days;

/**
 Returns a date representing the receiver date shifted later by the provided number of hours.
 
 @param hours  Number of hours to add.
 @return Date modified by the number of desired hours.
 */
- (nullable NSDate *)hx_dateByAddingHours:(NSInteger)hours;

/**
 Returns a date representing the receiver date shifted later by the provided number of minutes.
 
 @param minutes  Number of minutes to add.
 @return Date modified by the number of desired minutes.
 */
- (nullable NSDate *)hx_dateByAddingMinutes:(NSInteger)minutes;

/**
 Returns a date representing the receiver date shifted later by the provided number of seconds.
 
 @param seconds  Number of seconds to add.
 @return Date modified by the number of desired seconds.
 */
- (nullable NSDate *)hx_dateByAddingSeconds:(NSInteger)seconds;


#pragma mark - Date Format
///=============================================================================
/// @name Date Format
///=============================================================================

/**
 Returns a formatted string representing this date.
 see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
 for format description.
 
 @param format   String representing the desired date format.
 e.g. @"yyyy-MM-dd HH:mm:ss"
 
 @return NSString representing the formatted date string.
 */
- (nullable NSString *)hx_stringWithFormat:(NSString *)format;

/**
 Returns a formatted string representing this date.
 see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
 for format description.
 
 @param format    String representing the desired date format.
 e.g. @"yyyy-MM-dd HH:mm:ss"
 
 @param timeZone  Desired time zone.
 
 @param locale    Desired locale.
 
 @return NSString representing the formatted date string.
 */
- (nullable NSString *)hx_stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;

/**
 Returns a string representing this date in ISO8601 format.
 e.g. "2010-07-09T16:13:30+12:00"
 
 @return NSString representing the formatted date string in ISO8601.
 */
- (nullable NSString *)hx_stringWithISOFormat;

/**
 Returns a date parsed from given string interpreted using the format.
 
 @param dateString The string to parse.
 @param format     The string's date format.
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (nullable NSDate *)hx_dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 Returns a date parsed from given string interpreted using the format.
 
 @param dateString The string to parse.
 @param format     The string's date format.
 @param timeZone   The time zone, can be nil.
 @param locale     The locale, can be nil.
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (nullable NSDate *)hx_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;

/**
 Returns a date parsed from given string interpreted using the ISO8601 format.
 
 @param dateString The date string in ISO8601 format. e.g. "2010-07-09T16:13:30+12:00"
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (nullable NSDate *)hx_dateWithISOFormatString:(NSString *)dateString;

@end

NS_ASSUME_NONNULL_END
