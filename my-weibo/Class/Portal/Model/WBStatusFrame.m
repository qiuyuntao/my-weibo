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
    WBStatus *retweetStatus = _status.retweeted_status;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat topViewW= cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 头像
    CGFloat iconViewWH = 34;
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
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: StatusContentFont   } context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 图片
    _photoViewF = CGRectMake(iconViewY, CGRectGetMaxY(_contentLabelF) + StatusCellBorder, 100, 100);
    
    if (status.thumbnail_pic) {
        topViewH = CGRectGetMaxY(_photoViewF) + StatusCellBorder;
    } else {
        topViewH = CGRectGetMaxY(_contentLabelF) + StatusCellBorder;
    }
    
    // 如果存在转发的微博
    if (status.retweeted_status) {
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = topViewH;
        CGFloat retweetViewW = cellW;
        CGFloat retweetViewH = 0;
        
        // 昵称
        NSString *retweetName = [NSString stringWithFormat:@"@%@", retweetStatus.user.name];
        CGFloat retweetNameX = StatusCellBorder;
        CGFloat retweetNameY = StatusCellBorder;
        CGSize retweetNameSize = [retweetName sizeWithAttributes:@{NSFontAttributeName: StatusNameFont}];
        _retweetNameLabelF = (CGRect){{retweetNameX, retweetNameY}, retweetNameSize};
        
        // 正文
        CGFloat contentLabelW = retweetViewW - 2 * StatusCellBorder;
        CGFloat retweetContentLabelX = StatusCellBorder;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + StatusCellBorder;
        CGSize retweetContentLabelSize = [retweetStatus.text boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: StatusContentFont} context:nil].size;
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};

        // 图片
        _retweetPhotoViewF = CGRectMake(StatusCellBorder, CGRectGetMaxY(_retweetContentLabelF) + StatusCellBorder, 100, 100);
        
        if (retweetStatus.thumbnail_pic) {
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF) + 10;
        } else {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF) + 10;
        }
    
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else {
    
    }
    
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // statusBar
    _statusToolbarF = CGRectMake(0, CGRectGetMaxY(_topViewF), cellW, 36);
    
    _cellHeight = topViewH + _statusToolbarF.size.height + 10;
}

@end