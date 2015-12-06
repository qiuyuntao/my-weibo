//
//  PortalTableViewCell.h
//  my-weibo
//
//  Created by qyt on 12/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

#define StatusNameFont [UIFont systemFontOfSize:15]
#define StatusTimeFont [UIFont systemFontOfSize:12]
#define StatusSourceFont StatusTimeFont
#define StatusContentFont [UIFont systemFontOfSize:13]

@interface PortalTableViewCell : UITableViewCell

@property (nonatomic, strong) WBStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
