//
//  PlusButton.m
//  my-weibo
//
//  Created by qyt on 11/8/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "PlusButton.h"
#import "UIImage+my_weibo.h"

@implementation PlusButton

- (instancetype)init {
    PlusButton *btn = [super init];
    
    // set background image
    [btn setBackgroundImage:[UIImage imageWithOS7:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithOS7:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(btn.frame.origin.x,
                           btn.frame.origin.y,
                           btn.currentBackgroundImage.size.width,
                           btn.currentBackgroundImage.size.height);
    
    // set image
    [btn setImage:[UIImage imageWithOS7:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithOS7:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    return btn;
}

@end
