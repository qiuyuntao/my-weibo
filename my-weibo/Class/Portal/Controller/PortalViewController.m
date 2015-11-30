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
#import "PortalTitleButton.h"
#import "AFNetworking.h"
#import "OAuthAccount.h"

@interface PortalViewController ()

@end

@implementation PortalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initForTitleButton];
    [self initForBarButtonItem];
    
    [self getWBData];
}

- (void)getWBData {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
//    OAuthAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
//    NSLog(@"%@", account);
//    NSDictionary *parameters = @{
//                                 @"access_token": @""};
//    
//    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
}

- (void)initForTitleButton {
    PortalTitleButton *btn = [[PortalTitleButton alloc] init];
    self.navigationItem.titleView = btn;
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
