//
//  TabBar.m
//  my-weibo
//
//  Created by qyt on 11/7/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"
#import "UIImage+my_weibo.h"

@interface TabBar()

@property (nonatomic, weak)TabBarButton *selectedBtn;

@end

@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithOS7:@"tabbar_background"]];
    
    return self;
}

- (void)addTabBarWithItem:(UITabBarItem *)item {
    TabBarButton *button = [TabBarButton buttonWithItem:item];
    
    [self addSubview:button];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    long count = self.subviews.count;

    for (long i = 0; i < count; i++) {
        TabBarButton *button = self.subviews[i];
        
        CGFloat btnW = self.frame.size.width / count;
        CGFloat btnH = self.frame.size.height;
        CGFloat btnX = btnW * i;
        CGFloat btnY = 0;
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        button.tag = i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 0) {
            self.selectedBtn = button;
            button.selected = YES;
        }
    }
}

- (void)btnClick:(TabBarButton *)btn {
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectFrom:to:)]) {
        [self.delegate tabBar:self didSelectFrom:self.selectedBtn.tag to:btn.tag];
    }
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

@end
