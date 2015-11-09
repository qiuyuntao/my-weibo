//
//  UIBarButtonItem+my_weibo.h
//  my-weibo
//
//  Created by qyt on 11/9/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (my_weibo)

+ (UIBarButtonItem *)initWithCustomImage:(NSString *) customImage
                           hlightedImage:(NSString *)hlightedImage
                                  target:(id)target
                                  action:(SEL)action;

@end
