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
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = StatusCellBorder;
    CGFloat iconViewY = StatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 昵称
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName: StatusNameFont}];
    CGFloat nameLabelX = iconViewWH + StatusCellBorder * 2;
    CGFloat nameLabelY = StatusCellBorder;
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 时间
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName: StatusTimeFont}];
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = nameLabelSize.height + StatusCellBorder;
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 正文
    CGFloat contentLabelW = cellW - 2 * StatusCellBorder;
    CGFloat contentLabelX = StatusCellBorder;
    CGFloat contentLabelY = iconViewWH + StatusCellBorder * 2;
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: StatusTimeFont} context:nil].size;
//    CGSize contentLabelSize = [status.text sizeWithFont:StatusContentFont constrainedToSize:CGSizeMake(contentLabelW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    topViewH = CGRectGetMaxY(_contentLabelF) + StatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    _cellHeight = topViewH;
    
//    @property (nonatomic, assign, readonly) CGRect vipViewF;
//    @property (nonatomic, assign, readonly) CGRect photoViewF;
//    @property (nonatomic, assign, readonly) CGRect nameLabelF;
//    @property (nonatomic, assign, readonly) CGRect timeLabelF;
//    @property (nonatomic, assign, readonly) CGRect sourceLabelF;
//    @property (nonatomic, assign, readonly) CGRect contentLabelF;
}

@end