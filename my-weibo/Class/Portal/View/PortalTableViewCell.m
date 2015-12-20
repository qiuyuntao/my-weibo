//
//  PortalTableViewCell.m
//  my-weibo
//
//  Created by qyt on 12/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "PortalTableViewCell.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "StatusBarView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+my_weibo.h"
#import "StatusBarView.h"
#import "WBRetweet.h"
#import "WBTopView.h"

@interface PortalTableViewCell()

@property (nonatomic, weak) WBTopView *topView; // 顶部view

@property (nonatomic, weak) WBRetweet *retweetView;
@property (nonatomic, weak) StatusBarView *statusToolbar; // 转发微博工具条

@end

@implementation PortalTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"weibo";
    PortalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PortalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    WBTopView *topView = [[WBTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    [self initToolBar]; // 微博工具条
    
    return self;
}

- (void)setStatusFrame:(WBStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    self.topView.statusFrame = statusFrame;
    
    [self setDataForStatusBar];
}

- (void)setDataForStatusBar {
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}

- (void)initToolBar {
    // 工具条
    StatusBarView *statueBar = [[StatusBarView alloc] init];
    [self.contentView addSubview:statueBar];
    self.statusToolbar = statueBar;
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

@end
