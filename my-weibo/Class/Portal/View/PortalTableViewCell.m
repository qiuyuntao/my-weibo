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
    
    [self setRetweetDataForCell];
    
    [self setDataForStatusBar];
}

- (void)setOriginalDataForCell {
    WBStatusFrame *statusFrame = self.statusFrame;
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
    self.topView.frame = statusFrame.topViewF;
    self.topView.highlightedImage = [UIImage resizeImage:@"timeline_card_top_background_highlighted"];
    
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithOS7:@"avatar_default_small"]];
    
    self.nameLabel.frame = statusFrame.nameLabelF;
    [self.nameLabel setText:user.name];
    
    
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName: StatusTimeFont}];
    CGRect timeLabelF = (CGRect){{statusFrame.timeLabelF.origin.x, statusFrame.timeLabelF.origin.y}, timeLabelSize};
    self.timeLabel.frame = timeLabelF;
    [self.timeLabel setText:status.created_at];
    
    self.contentLabel.frame = statusFrame.contentLabelF;
    [self.contentLabel setText:status.text];
    
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithOS7:@"avatar_default_small"]];
    } else {
        self.photoView.hidden = YES;
    }
}

- (void)setRetweetDataForCell {
    WBStatusFrame *statusFrame = self.statusFrame;
    WBStatus *retweetStatus = statusFrame.status.retweeted_status;
    
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        self.retweetNameLabel.frame = statusFrame.retweetNameLabelF;
        NSString *retweetName = [NSString stringWithFormat:@"@%@", retweetStatus.user.name];
        self.retweetNameLabel.text = retweetName;
        
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.text = retweetStatus.text;
        
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithOS7:@"avatar_default_small"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
}

- (void)setDataForStatusBar {
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}

- (void)initOriginalSubviews {
    
    // 顶部view
    UIImageView *topView = [[UIImageView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
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
    self.photoView.hidden = YES;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
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
    retweetView.hidden = YES;
    retweetView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    // 转发昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [retweetNameLabel setFont:StatusNameFont];
    retweetNameLabel.textColor = [UIColor colorWithRed:0.34 green:0.54 blue:0.76 alpha:1];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    // 转发正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetContentLabel setFont:StatusContentFont];
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    // 转发配图
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    retweetPhotoView.hidden = YES;
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

- (void)initToolBar {
    // 工具条
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolbar];
    statusToolbar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.statusToolbar = statusToolbar;
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    
    [super setFrame:frame];
}








@end
