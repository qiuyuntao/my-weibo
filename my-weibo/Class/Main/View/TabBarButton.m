//
//  TabBarButton.m
//  my-weibo
//
//  Created by qyt on 11/7/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

+ (TabBarButton *)buttonWithItem:(UITabBarItem *)item {
    TabBarButton *button = [TabBarButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.imageView.contentMode = UIViewContentModeCenter;
    
    return button;
}

// 去除自带的长按效果
- (void)setHighlighted:(BOOL)highlighted {}

// 自定义图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 0, imageW, imageH);
}

// 自定义文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * 0.4;
    return CGRectMake(0, contentRect.size.height * 0.6, titleW, titleH);
}

@end
