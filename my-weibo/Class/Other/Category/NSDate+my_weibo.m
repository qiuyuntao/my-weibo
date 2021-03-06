//
//  NSDate+my_weibo.m
//  my-weibo
//
//  Created by qyt on 12/13/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "NSDate+my_weibo.h"

@implementation NSDate (my_weibo)

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    //
    //    // 1.获得当前时间的年月日
    //    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    //
    //    // 2.获得self的年月日
    //    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    //    return
    //    (selfCmps.year == nowCmps.year) &&
    //    (selfCmps.month == nowCmps.month) &&
    //    (selfCmps.day == nowCmps.day);
    return NO;
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
