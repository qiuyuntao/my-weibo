//
//  WBTopView.m
//  my-weibo
//
//  Created by qyt on 12/20/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "WBTopView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBRetweet.h"
#import "UIImage+my_weibo.h"
#import "UIImageView+WebCache.h"
#import "WBUser.h"

@interface WBTopView()

@property (nonatomic, weak) UIImageView *iconView; // 头像
@property (nonatomic, weak) UIImageView *vipView; // 会员图标
@property (nonatomic, weak) UIImageView *photoView; // 配图
@property (nonatomic, weak) UILabel *nameLabel; // 昵称
@property (nonatomic, weak) UILabel *timeLabel; // 时间
@property (nonatomic, weak) UILabel *sourceLabel; // 来源
@property (nonatomic, weak) UILabel *contentLabel; // 正文

@property (nonatomic, weak) WBRetweet *retweetView; // 转发

@end

@implementation WBTopView

- (instancetype)init {
    self = [super init];
    
    [self initForView];
    [self initForRetweetView];
    
    return self;
}

- (void)initForView {
    
    // 顶部view
    self.backgroundColor = [UIColor whiteColor];
    
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // VIP
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    self.vipView = vipView;
    
    // 配图
    UIImageView *photoView = [[UIImageView alloc] init];
    [self addSubview:photoView];
    self.photoView = photoView;
    self.photoView.hidden = YES;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    [self addSubview:nameLabel];
    [nameLabel setFont:StatusNameFont];
    self.nameLabel = nameLabel;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = StatusTimeFont;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = StatusContentFont;
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)initForRetweetView {
    WBRetweet *retweetView = [[WBRetweet alloc] init];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}

- (void)setStatusFrame:(WBStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
    self.frame = statusFrame.topViewF;
    self.highlightedImage = [UIImage resizeImage:@"timeline_card_top_background_highlighted"];
    
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
    
    self.retweetView.statusFrame = statusFrame;
}

@end
