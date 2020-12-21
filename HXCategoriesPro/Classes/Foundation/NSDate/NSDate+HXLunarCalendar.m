//
//  NSDate+HXLunarCalendar.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/14.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSDate+HXLunarCalendar.h"
#import "NSDate+HXCommon.h"

//天干
#define HX_ChineseHeavenlyStems @[@"甲", @"乙", @"丙", @"丁", @"戊", @"己", @"庚", @"辛", @"壬", @"癸"]

//地支
#define HX_ChineseEarthlyBranches @[@"子", @"丑", @"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥"]

//十二生肖
#define HX_ChineseZodiac @[@"鼠", @"牛", @"虎", @"兔", @"龙", @"蛇", @"马", @"羊", @"猴", @"鸡", @"狗", @"猪"]

//农历月
#define HX_ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]

//农历日
#define HX_ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

//二十四节气（还没有实现）
#define HX_ChineseWeatherFestival @[@"立春",@"雨水",@"惊蛰",@"春分",@"清明",@"谷雨",@"立夏",@"小满",@"忙种",@"夏至",@"小暑",@"大暑",@"立秋",@"处暑",@"寒露",@"霜降",@"白露",@"秋分",@"立冬",@"小雪",@"大雪",@"冬至",@"小寒",@"大寒"]

//节日（还没有实现）
#define HX_ChineseFestival @[@"除夕",@"春节",@"中秋",@"五一",@"国庆",@"儿童",@"圣诞",@"七夕",@"端午"]

@implementation NSDate (HXLunarCalendar)

+ (NSCalendar *)hx_chineseCalendar {
    
    static NSCalendar *hx_chineseCalendar_sharedCalendar = nil;
    if (!hx_chineseCalendar_sharedCalendar) {
        hx_chineseCalendar_sharedCalendar =[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    }
    return hx_chineseCalendar_sharedCalendar;
}

//干支纪年
- (NSString *)hx_HE_Y_DateString {
    
    NSCalendar *chineseCalendar = [[self class] hx_chineseCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear;
    NSDateComponents *components = [chineseCalendar components:unitFlags fromDate:self];
    NSString *heavenlyStems = HX_ChineseHeavenlyStems[(components.year - 1) % HX_ChineseHeavenlyStems.count];
    NSString *earthlyBranches = HX_ChineseEarthlyBranches[(components.year - 1) % HX_ChineseEarthlyBranches.count];
    
    return [heavenlyStems stringByAppendingString:earthlyBranches];
}

//干支纪月
- (NSString *)hx_HE_M_DateString {
    
    NSCalendar *chineseCalendar = [[self class] hx_chineseCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *components = [chineseCalendar components:unitFlags fromDate:self];

    NSArray<NSString *> *h_m;
    
    switch ((components.year - 1) % HX_ChineseHeavenlyStems.count) {
        case 0:
        case 5:
            h_m = [[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(2, 8)] arrayByAddingObjectsFromArray:[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(0, 4)]];
            break;
        case 1:
        case 6:
            h_m = [[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(4, 6)] arrayByAddingObjectsFromArray:[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(0, 6)]];
            break;
        case 2:
        case 7:
            h_m = [[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(6, 4)] arrayByAddingObjectsFromArray:[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(0, 8)]];
            break;
        case 3:
        case 8:
            h_m = [[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(8, 2)] arrayByAddingObjectsFromArray:[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(0, 10)]];
            break;
        case 4:
        case 9:
            h_m = [[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(0, 10)] arrayByAddingObjectsFromArray:[HX_ChineseHeavenlyStems subarrayWithRange:NSMakeRange(8, 2)]];
            break;
    }
    
    NSArray<NSString *> *e_m = [[HX_ChineseEarthlyBranches subarrayWithRange:NSMakeRange(2, 10)] arrayByAddingObjectsFromArray:[HX_ChineseEarthlyBranches subarrayWithRange:NSMakeRange(0, 2)]];
    
    return [h_m[components.month - 1] stringByAppendingString:e_m[components.month - 1]];
}

//干支纪日 (目前支持 1700 ~ 2699 年)
- (NSString *)hx_HE_D_DateString {
    
    //公元年前两位
    NSInteger s = self.hx_year % 100;
    
    //它就是个参数
    NSInteger u = s % 4;
    
    //月序数
    NSInteger m = 0;
    switch (self.hx_month) {
        case 3:     m = 0;      break;
        case 4:     m = 31;     break;
        case 5:     m = 1;      break;
        case 6:     m = 32;     break;
        case 7:     m = 2;      break;
        case 8:     m = 33;     break;
        case 9:     m = 4;      break;
        case 10:    m = 34;     break;
        case 11:    m = 5;      break;
        case 12:    m = 35;     break;
        case 13:    m = 6;      break;
        case 14:    m = 37;     break;
        default:break;
    }
    
    //日期
    NSInteger d = self.hx_day;
    
    //世纪常数
    NSInteger x = 0;
    
    switch (self.hx_year / 100 + 1) {
        case 17:    x = 57;    break;
        case 18:    x = 41;    break;
        case 19:    x = 25;    break;
        case 20:    x = 9;     break;
        case 21:    x = 54;    break;
        case 22:    x = 38;    break;
        case 23:    x = 22;    break;
        case 24:    x = 6;     break;
        case 25:    x = 51;    break;
        case 26:    x = 35;    break;
        default:break;
    }
    
    /*
     符号意义
     
     r：日柱的母数，r 除以60的余数即是日柱的干支序列数；
     s：公元年数后两位数，取整数部分；
     u：s 除以4的余数；
     m：月基数
     d：日期数
     x：世纪常数
     */
    
    /* 高氏日柱公式 */
    NSInteger r = (s / 4) * 6 + 5 * (s / 4 * 3 + u) + m + d + x;
    
    //60年一个循环
    r %= 60;
    
    NSString *heavenlyStems = HX_ChineseHeavenlyStems[(r - 1) % HX_ChineseHeavenlyStems.count];
    NSString *earthlyBranches = HX_ChineseEarthlyBranches[(r - 1) % HX_ChineseEarthlyBranches.count];
    
    return [heavenlyStems stringByAppendingString:earthlyBranches];
}

//农历月
- (NSString*)hx_L_M_DateString {
    
    NSCalendar *chineseCalendar = [[self class] hx_chineseCalendar];
    
    unsigned unitFlags = NSCalendarUnitMonth;
    NSDateComponents *components = [chineseCalendar components:unitFlags fromDate:self];
    
    NSString *month = HX_ChineseMonths[components.month - 1];
    if (components.isLeapMonth) {
        month = [@"闰" stringByAppendingString:month];
    }
    
    return month;
}

//农历日
- (NSString*)hx_L_D_DateString {
    
    NSCalendar *chineseCalendar = [[self class] hx_chineseCalendar];
    
    unsigned unitFlags = NSCalendarUnitDay;
    NSDateComponents *components = [chineseCalendar components:unitFlags fromDate:self];
    
    NSString *day  = HX_ChineseDays[components.day - 1];
    
    return day;
}

//生肖
- (NSString *)hx_zodiac {
    
    NSCalendar *chineseCalendar = [[self class] hx_chineseCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear;
    NSDateComponents *components = [chineseCalendar components:unitFlags fromDate:self];
    
    return HX_ChineseZodiac[(components.year - 1) % HX_ChineseZodiac.count];
}

@end
