//
//  NSString+HXUUID.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/9.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSString+HXUUID.h"

@implementation NSString (HXUUID)

+ (NSString *)hx_UUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)hx_timeStamp {
    return  [[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970] * 1000.] stringValue];
}

+ (NSString *)hx_timeStampToString:(NSString *)timeStamp format:(NSString *)format {
    NSInteger createTime = timeStamp.integerValue;
    if (![format containsString:@"SSS"]) {
        createTime = createTime > (NSInteger)9999999999 ? createTime / 1000 : createTime;
    }
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:createTime];
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}
@end
