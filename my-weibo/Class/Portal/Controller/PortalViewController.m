//
//  PortalViewController.m
//  my-weibo
//
//  Created by qyt on 11/4/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "PortalViewController.h"
#import "UIImage+my_weibo.h"
#import "UIBarButtonItem+my_weibo.h"

@interface PortalViewController ()

@end

@implementation PortalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initForBarButtonItem];
}

- (void)initForBarButtonItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithCustomImage:@"navigationbar_friendsearch" hlightedImage:@"navigationbar_friendsearch_highlighted" target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithCustomImage:@"navigationbar_pop" hlightedImage:@"navigationbar_pop_highlighted" target:self action:nil];
}

- (void)click {
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
