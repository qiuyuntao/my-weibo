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

@property (nonatomic, strong) NSMutableArray *statusFrame;

@end

@implementation PortalViewController

- (NSMutableArray *)statusFrame
{
    if (_statusFrame == nil) {
        _statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRefresh];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initForTitleButton];
    [self initForBarButtonItem];
    
}

- (void) initRefresh {
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    
    [refresh beginRefreshing];
    [self refreshData:refresh];
}

- (void)refreshData:(UIRefreshControl *)refresh {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    OAuthAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"amount"] = @5;
    
    if (self.statusFrame.count) {
        WBStatusFrame *statusFrame = self.statusFrame[0];
        parameters[@"since_id"] = statusFrame.status.idstr;
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *statusArr = [NSArray yy_modelArrayWithClass:[WBStatus class] json:responseObject[@"statuses"]];
        NSMutableArray *arr = [NSMutableArray array];
        
        for (WBStatus *status in statusArr) {
            WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
            statusFrame.status = status;
            [arr addObject:statusFrame];
        }
        
        NSMutableArray *tempArray = [NSMutableArray array];
        // 添加statusFrameArray的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:arr];
        // 添加self.statusFrames的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:self.statusFrame];
        self.statusFrame = tempArray;
        
        [self.tableView reloadData];

        [refresh endRefreshing];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBStatusFrame *frame = self.statusFrame[indexPath.row];
    
    return frame.cellHeight;
}

@end
