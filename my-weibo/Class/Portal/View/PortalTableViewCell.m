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
#import "UIImageView+WebCache.h"
#import "UIImage+my_weibo.h"

@interface PortalTableViewCell()

@property (nonatomic, weak) UIImageView *topView; // 顶部view
@property (nonatomic, weak) UIImageView *iconView; // 头像
@property (nonatomic, weak) UIImageView *vipView; // 会员图标
@property (nonatomic, weak) UIImageView *photoView; // 配图
@property (nonatomic, weak) UILabel *nameLabel; // 昵称
@property (nonatomic, weak) UILabel *timeLabel; // 时间
@property (nonatomic, weak) UILabel *sourceLabel; // 来源
@property (nonatomic, weak) UILabel *contentLabel; // 正文

// 转发
@property (nonatomic, weak) UIImageView *retweetView; // 转发微博view
@property (nonatomic, weak) UILabel *retweetNameLabel; // 转发微博昵称
@property (nonatomic, weak) UILabel *retweetContentLabel; // 转发微博正文
@property (nonatomic, weak) UIImageView *retweetPhotoView; // 转发微博配图
@property (nonatomic, weak) UIImageView *statusToolbar; // 转发微博工具条

@end

@implementation PortalTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"weibo";
    PortalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PortalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    [self initOriginalSubviews]; // 原创微博
    [self initRetweetSubviews]; // 转发微博
    [self initToolBar]; // 微博工具条
    
    return self;
}

- (void)setStatusFrame:(WBStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    [self setOriginalDataForCell];
}

-(void)setOriginalDataForCell {
    WBStatusFrame *statusFrame = self.statusFrame;
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
    self.topView.frame = statusFrame.topViewF;
    
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithOS7:@"avatar_default_small"]];
    
    self.nameLabel.frame = statusFrame.nameLabelF;
    [self.nameLabel setText:user.name];
    
    self.timeLabel.frame = statusFrame.timeLabelF;
    [self.timeLabel setText:status.created_at];
    
    self.contentLabel.frame = statusFrame.contentLabelF;
    [self.contentLabel setText:status.text];
}

- (void)initOriginalSubviews {
    
    // 顶部view
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;

    // VIP
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.contentView addSubview:vipView];
    self.vipView = vipView;
    
    // 配图
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nameLabel];
    [nameLabel setFont:StatusNameFont];
    self.nameLabel = nameLabel;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = StatusTimeFont;
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = StatusContentFont;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)initRetweetSubviews {
    // 父控件
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    // 转发昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    // 转发正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    // 转发配图
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

- (void)initToolBar {
    // 工具条
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
