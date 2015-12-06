//
//  WBStatusFrame.m
//  my-weibo
//
//  Created by qyt on 12/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"

#define StatusCellBorder 5

@implementation WBStatusFrame

-(void)setStatus:(WBStatus *)status {
    _status = status;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat topViewW= cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = StatusCellBorder;
    CGFloat iconViewY = StatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName: StatusNameFont}];
    CGFloat nameLabelX = iconViewWH + StatusCellBorder * 2;
    CGFloat nameLabelY = 0;
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewW);
    
//    @property (nonatomic, assign, readonly) CGRect vipViewF;
//    @property (nonatomic, assign, readonly) CGRect photoViewF;
//    @property (nonatomic, assign, readonly) CGRect nameLabelF;
//    @property (nonatomic, assign, readonly) CGRect timeLabelF;
//    @property (nonatomic, assign, readonly) CGRect sourceLabelF;
//    @property (nonatomic, assign, readonly) CGRect contentLabelF;
}

@end