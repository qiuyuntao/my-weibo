//
//  TabBar.m
//  my-weibo
//
//  Created by qyt on 11/7/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

- (void)addTabBarWithItem:(UITabBarItem *)item {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    
    [self addSubview:button];
    
    NSLog(@"%f", self.frame.size.width);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    long count = self.subviews.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        
        CGFloat btnW = self.frame.size.width / count;
        CGFloat btnH = self.frame.size.height;
        CGFloat btnX = btnW * i;
        CGFloat btnY = 0;
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
