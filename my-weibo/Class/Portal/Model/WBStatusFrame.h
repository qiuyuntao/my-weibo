//
//  WBStatusFrame.h
//  my-weibo
//
//  Created by qyt on 12/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WBStatus;

#define StatusNameFont [UIFont systemFontOfSize:15]
#define StatusTimeFont [UIFont systemFontOfSize:12]
#define StatusSourceFont StatusTimeFont
#define StatusContentFont [UIFont systemFontOfSize:13]

@interface WBStatusFrame : NSObject

@property (nonatomic, strong) WBStatus *status;

@property (nonatomic, assign, readonly) CGRect topViewF;
@property (nonatomic, assign, readonly) CGRect iconViewF;
@property (nonatomic, assign, readonly) CGRect vipViewF;
@property (nonatomic, assign, readonly) CGRect photoViewF;
@property (nonatomic, assign, readonly) CGRect nameLabelF;
@property (nonatomic, assign, readonly) CGRect timeLabelF;
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
@property (nonatomic, assign, readonly) CGRect contentLabelF;


@property (nonatomic, assign, readonly) CGRect retweetViewF;
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;


@property (nonatomic, assign, readonly) CGRect statusToolbarF;


@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end
