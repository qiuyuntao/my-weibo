//
//  WBRootViewController.m
//  my-weibo
//
//  Created by qyt on 11/4/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "WBRootViewController.h"
#import "PortalViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "UIImage+my_weibo.h"
#import "TabBar.h" // DIY tabBar

@interface WBRootViewController () <TabBarDelegate>

@property (nonatomic, weak) TabBar *diyTabBar;

@end

@implementation WBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // DIY tabbar for controller
    [self initTabBar];
    
    // init viewController
    [self initView];
}

// DIY tabbar for controller
- (void) initTabBar {
    TabBar *tabBar = [[TabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    tabBar.delegate = self;
    self.diyTabBar = tabBar;
}


// delete custom tabBar view
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void) initView {
    PortalViewController *portal = [[PortalViewController alloc] init];
    portal.tabBarItem.badgeValue = @"1";
    [self initViewController:portal withTitle:@"首页" withImage:@"tabbar_home"];
    
    MessageViewController *message = [[MessageViewController alloc] init];
    message.tabBarItem.badgeValue = @"new";
    [self initViewController:message withTitle:@"消息" withImage:@"tabbar_message_center"];
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self initViewController:discover withTitle:@"发现" withImage:@"tabbar_discover"];
    
    MeViewController *me = [[MeViewController alloc] init];
    [self initViewController:me withTitle:@"我的" withImage:@"tabbar_profile"];
}

- (void) initViewController:(UIViewController *) vc
                      withTitle:(NSString *)title
                      withImage:(NSString *)imageName {
    NSString *selectImageName = [imageName stringByAppendingString:@"_selected"];
    
    vc.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.image = [UIImage imageWithOS7:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageWithOS7:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; // 图片不做任何渲染
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    [self.diyTabBar addTabBarWithItem:vc.tabBarItem];
}

- (void)tabBar:(TabBar *)tabBar didSelectFrom:(long)from to:(long)to {
    self.selectedIndex = to;
}

@end
