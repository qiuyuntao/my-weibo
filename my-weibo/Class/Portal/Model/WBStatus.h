//
//  WBStatus.h
//  my-weibo
//
//  Created by qyt on 12/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUser;

@interface WBStatus : NSObject

@property (nonatomic, copy) NSString *text; // 微博文字
@property (nonatomic, copy) NSString *source; // 微博来源
@property (nonatomic, copy) NSString *idstr; // 用户id
@property (nonatomic, assign) int reposts_count; // 微博转发数
@property (nonatomic, assign) int comments_count; // 微博评论数
@property (nonatomic, copy) NSString *created_at; // 创建时间
@property (nonatomic, strong) WBUser *user; // 微博作者


@end
