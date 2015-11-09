//
//  NavViewController.m
//  my-weibo
//
//  Created by qyt on 11/9/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "NavViewController.h"
#import "UIImage+my_weibo.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 一个类初始化的时候只会初始化一次
+ (void)initialize {
    [self initForNavBar];
    [self initForRightBtn];
}


// 自定义导航栏
+ (void)initForNavBar {

}

// 自定义右边按钮
+ (void)initForRightBtn {
//    UIBarButtonItem *btn = [UIBarButtonItem appearance];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:YES];
}

@end
