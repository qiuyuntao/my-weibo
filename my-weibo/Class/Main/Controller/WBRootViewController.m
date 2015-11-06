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

@interface WBRootViewController ()

@end

@implementation WBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // init viewController
    [self initView];
}

- (void) initView {
    PortalViewController *portal = [[PortalViewController alloc] init];
    [self initViewController:portal withTitle:@"首页" withImage:@"tabbar_home"];
    
    MessageViewController *message = [[MessageViewController alloc] init];
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
}

@end
