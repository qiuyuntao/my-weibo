//
//  BadgeValueButton.m
//  my-weibo
//
//  Created by qyt on 11/8/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "BadgeValueButton.h"
#import "UIImage+my_weibo.h"

@implementation BadgeValueButton

+ (BadgeValueButton *)initWithValue:(NSString *)value {
    BadgeValueButton *btn = [[BadgeValueButton alloc] init];
    [btn setBackgroundImage:[UIImage resizeImage:@"main_badge"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
//    btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    btn.badgeValue = value;
    
    return btn;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    
    if (badgeValue) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        CGFloat x = self.superview.frame.size.width * 0.5;
        CGFloat y = 0;
        CGFloat w = self.currentBackgroundImage.size.width;
        CGFloat h = self.currentBackgroundImage.size.height;
        if (badgeValue.length != 1) {
            w = [badgeValue sizeWithAttributes:@{@"NSFontAttributeName": self.titleLabel.font}].width + 10; // 字体大小
        }
        self.frame = CGRectMake(x, y, w, h);
    } else {
        self.hidden = YES;
    }
}

@end
