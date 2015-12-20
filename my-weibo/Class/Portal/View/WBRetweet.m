//
//  WBRetweet.m
//  my-weibo
//
//  Created by qyt on 12/20/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "WBRetweet.h"
#import "WBStatus.h"
#import "WBStatusFrame.h"
#import "WBUser.h"
#import "UIImage+my_weibo.h"
#import "UIImageView+WebCache.h"

@interface WBRetweet()

// 转发
@property (nonatomic, weak) UILabel *retweetNameLabel; // 转发微博昵称
@property (nonatomic, weak) UILabel *retweetContentLabel; // 转发微博正文
@property (nonatomic, weak) UIImageView *retweetPhotoView; // 转发微博配图

@end

@implementation WBRetweet

- (instancetype)init {
    self = [super init];
    
    [self initForView];
    
    return self;
}

- (void)initForView {
    // 父控件
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    
    // 转发昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [retweetNameLabel setFont:StatusNameFont];
    retweetNameLabel.textColor = [UIColor colorWithRed:0.34 green:0.54 blue:0.76 alpha:1];
    [self addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    // 转发正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetContentLabel setFont:StatusContentFont];
    retweetContentLabel.numberOfLines = 0;
    [self addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    // 转发配图
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    retweetPhotoView.hidden = YES;
    [self addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

- (void)setStatusFrame:(WBStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    WBStatus *status = statusFrame.status.retweeted_status;
    
    if (status) {
        self.hidden = NO;
        self.frame = statusFrame.retweetViewF;
        
        self.retweetNameLabel.frame = statusFrame.retweetNameLabelF;
        NSString *retweetName = [NSString stringWithFormat:@"@%@", status.user.name];
        self.retweetNameLabel.text = retweetName;
        
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.text = status.text;
        
        if (status.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithOS7:@"avatar_default_small"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.hidden = YES;
    }
}

@end
