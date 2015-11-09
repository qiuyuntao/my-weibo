//
//  TabBar.m
//  my-weibo
//
//  Created by qyt on 11/7/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"
#import "PlusButton.h"
#import "UIImage+my_weibo.h"

@interface TabBar()

@property (nonatomic, weak)TabBarButton *selectedBtn;
@property (nonatomic, weak)PlusButton *plusButton;

@end

@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithOS7:@"tabbar_background"]];
    [self initForPlusButton];
    
    return self;
}

- (void)initForPlusButton {
    PlusButton *plusButton = [[PlusButton alloc] init];
    [self addSubview:plusButton];
    [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchDown];
    
    self.plusButton = plusButton;
}

- (void)addTabBarWithItem:(UITabBarItem *)item {
    TabBarButton *button = [TabBarButton buttonWithItem:item];
    
    [self addSubview:button];
}

- (void)layoutSubviews {
    [super layoutSubviews];    
    
    long count = self.subviews.count;
    
    for (long i = 0; i < count; i++) {
        if (i == 0) {
            self.plusButton.center = CGPointMake(self.frame.size.width * 0.5,
                                                 self.frame.size.height * 0.5);
            continue;
        }
        TabBarButton *button = self.subviews[i];
        
        CGFloat btnW = self.frame.size.width / count;
        CGFloat btnH = self.frame.size.height;
        
        CGFloat btnX = btnW * (i - 1);
        CGFloat btnY = 0;
        
        if (i > 2) btnX += btnW;
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        button.tag = i - 1;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 1) {
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

- (void)plusButtonClick {
    if ([self.delegate respondsToSelector:@selector(tapPlusButton)]) {
        [self.delegate tapPlusButton];
    }
}

@end
