//
//  StatusBarView.m
//  my-weibo
//
//  Created by qyt on 12/15/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "StatusBarView.h"
#import "UIImage+my_weibo.h"
#import "WBStatus.h"

@interface StatusBarView()

@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, strong) NSMutableArray *divideLineArr;
@property (nonatomic, weak) UIButton *reweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation StatusBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    self.reweetBtn = [self btnWithTitle:@"转发" image:@"timeline_icon_retweet"];
    self.commentBtn = [self btnWithTitle:@"评论" image:@"timeline_icon_comment"];
    self.attitudeBtn = [self btnWithTitle:@"赞" image:@"timeline_icon_unlike"];
    
    return self;
}

- (void)setStatus:(WBStatus *)status {
    _status = status;

    [self btnWithCount:self.reweetBtn originTitle:@"转发" count:status.reposts_count];
    [self btnWithCount:self.commentBtn originTitle:@"评论" count:status.comments_count];
    [self btnWithCount:self.attitudeBtn originTitle:@"赞" count:status.attitudes_count];
}

- (void)btnWithCount:(UIButton *)btn originTitle:(NSString *)originTitle count:(int)count {
    if (count != 0) {
        NSString *title = @"";
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        } else {
            int x = count / 10000;
            if (count - x * 10000 > 1000) {
                title = [NSString stringWithFormat:@"%d.%d万", x, (count - x * 10000) / 1000];
            } else {
                title = [NSString stringWithFormat:@"%d万", x];
            }
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:originTitle forState:UIControlStateNormal];
    }
}

- (UIButton *)btnWithTitle:(NSString *)title image:(NSString *)imageName {
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageWithOS7:imageName] forState:UIControlStateNormal];
    
    UIImage *normalImage = [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [self imageWithColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1]];
    [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.adjustsImageWhenHighlighted = NO;
    
    [self.btnArr addObject:btn];
    
    return btn;
}

- (void)layoutSubviews {
    CGFloat width = (self.frame.size.width - 2) / 3;
    for (int i = 0; i < self.btnArr.count; i++) {
        UIButton *btn = self.btnArr[i];
        btn.frame = CGRectMake(width * i + i * 2, 1, width, self.frame.size.height - 1);
        
        [self addSubview:btn];
    }
    
    for (int i = 0; i < 2; i++) {
        UIImageView *divideView = [[UIImageView alloc] init];
        divideView.highlighted = NO;
        divideView.frame = CGRectMake(width * (i + 1) + i + 1, 1, 1, self.frame.size.height - 1);
        divideView.image = [UIImage imageWithOS7:@"timeline_card_bottom_line"];
        [self addSubview:divideView];
    }
    
    UIView *divideLine = [[UIView alloc] init];
    divideLine.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    divideLine.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    [self addSubview:divideLine];
}

- (NSMutableArray *)btnArr {
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    
    return _btnArr;
}

- (NSMutableArray *)divideLineArr {
    if (_divideLineArr == nil) {
        _divideLineArr = [NSMutableArray array];
    }
    
    return _divideLineArr;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end
