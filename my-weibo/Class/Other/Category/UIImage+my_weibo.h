//
//  UIImage+my_weibo.h
//  my-weibo
//
//  Created by qyt on 11/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (my_weibo)

+ (UIImage *)imageWithOS7:(NSString *)name; // 文件名加上os7后缀
+ (UIImage *)resizeImage:(NSString *)name; // 拉伸图片

@end
