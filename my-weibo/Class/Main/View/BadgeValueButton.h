//
//  BadgeValueButton.h
//  my-weibo
//
//  Created by qyt on 11/8/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeValueButton : UIButton

+ (BadgeValueButton *)initWithValue:(NSString *)value;

@property (nonatomic, copy) NSString *badgeValue;

@end
