//
//  UIImage+my_weibo.m
//  my-weibo
//
//  Created by qyt on 11/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "UIImage+my_weibo.h"

@implementation UIImage (my_weibo)

// 文件名加上os7后缀
+ (UIImage *)imageWithOS7:(NSString *)name {
    NSString *newName = [name stringByAppendingString:@"_os7"];
    UIImage *image = [UIImage imageNamed:newName];
    if (image == nil) {
        return [UIImage imageNamed:name];
    }
    return image;
}

// 拉伸图片
+ (UIImage *)resizeImage:(NSString *)name {
    UIImage *image = [UIImage imageWithOS7:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
