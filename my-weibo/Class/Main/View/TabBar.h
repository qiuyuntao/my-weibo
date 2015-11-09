//
//  TabBar.h
//  my-weibo
//
//  Created by qyt on 11/7/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBar;


@protocol TabBarDelegate <NSObject>

- (void)tabBar:(TabBar *)tabBar didSelectFrom:(long)from to:(long)to; // 按钮点击代理事件
- (void)tapPlusButton; // 点击加号按钮

@end

@interface TabBar : UIView

- (void)addTabBarWithItem:(UITabBarItem *)item; // DIT tabBar

@property (assign, nonatomic)id <TabBarDelegate>delegate;

@end
