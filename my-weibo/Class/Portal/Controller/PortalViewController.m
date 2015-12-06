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
#import "UIImageView+WebCache.h"
#import "WBStatus.h"
#import "WBStatusFrame.h"
#import "WBUser.h"
#import "YYModel.h"
#import "PortalTableViewCell.h"

@interface PortalViewController ()

@property (nonatomic, strong) NSArray *statusFrame;

@end

@implementation PortalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initForTitleButton];
    [self initForBarButtonItem];
    
    [self getWBData];
}

- (void)getWBData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    OAuthAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSDictionary *parameters = @{
                                 @"access_token": account.access_token};
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *statusArr = [WBStatus yy_modelArrayWithJSON:responseObject[@"statuses"]];
        NSMutableArray *arr = [NSMutableArray array];
        
        for (WBStatus *status in statusArr) {
            WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
            statusFrame.status = status;
            [arr addObject:statusFrame];
        }
        
        self.statusFrame = arr;
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrame.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     // 1.创建cell
     PortalTableViewCell *cell = [PortalTableViewCell cellWithTableView:tableView];
     cell.statusFrame = self.statusFrame[indexPath.row];
     
     return cell;
}

@end
