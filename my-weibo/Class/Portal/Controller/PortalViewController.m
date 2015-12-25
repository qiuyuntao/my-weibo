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
#import "OAuthAccountTool.h"

@interface PortalViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrame;
@property (nonatomic, weak) PortalTitleButton *titleBtn;

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
    [self getUserInfo];
    
}

- (void)getUserInfo {
    self.titleBtn.frame = CGRectMake(0, 0, 0, 40);
    OAuthAccount *accout = [OAuthAccountTool account];
    NSString *name;
    if (accout.name) {
        name = accout.name;
    } else {
        name = @"首页";
    }
    [self.titleBtn setTitle:name forState:UIControlStateNormal];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    OAuthAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = @(account.uid);
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        WBUser *user = [WBUser yy_modelWithDictionary:responseObject];
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
        OAuthAccount *accout_1 = [OAuthAccountTool account];
        accout_1.name = user.name;
        [OAuthAccountTool saveAccount:accout_1];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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
        
        [self showNewWBCount:arr.count];
        [refresh endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)showNewWBCount:(long)count {
    UIButton *showBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 34, self.view.frame.size.width, 30)];
    [showBtn setBackgroundImage:[UIImage resizeImage:@"timeline_new_status_background"] forState:UIControlStateNormal];
    showBtn.userInteractionEnabled = NO;
    NSString *text = @"";
    if (count == 0) {
        text = @"没有新消息";
    } else {
        text = [NSString stringWithFormat:@"共有%ld条新消息", count];
    }
    [showBtn setTitle:text forState:UIControlStateNormal];
    showBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    showBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [showBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:showBtn belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.7 animations:^{
        showBtn.transform = CGAffineTransformMakeTranslation(0, showBtn.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:1 options:(UIViewAnimationOptionCurveLinear) animations:^{
            showBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [showBtn removeFromSuperview];
        }];
    }];
}

- (void)initForTitleButton {
    PortalTitleButton *btn = [[PortalTitleButton alloc] init];
    self.navigationItem.titleView = btn;
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    self.titleBtn = btn;
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
