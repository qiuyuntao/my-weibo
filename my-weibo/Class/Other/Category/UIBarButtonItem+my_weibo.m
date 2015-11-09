//
//  UIBarButtonItem+my_weibo.m
//  my-weibo
//
//  Created by qyt on 11/9/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "UIBarButtonItem+my_weibo.h"
#import "UIImage+my_weibo.h"

@implementation UIBarButtonItem (my_weibo)

+ (UIBarButtonItem *)initWithCustomImage:(NSString *) customImage
                           hlightedImage:(NSString *)hlightedImage
                                  target:(id)target
                                  action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageWithOS7:customImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithOS7:hlightedImage] forState:UIControlStateHighlighted];
    btn.frame = (CGRect){CGPointZero, btn.currentBackgroundImage.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
