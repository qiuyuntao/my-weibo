//
//  NSDate+my_weibo.h
//  my-weibo
//
//  Created by qyt on 12/13/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (my_weibo)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end
