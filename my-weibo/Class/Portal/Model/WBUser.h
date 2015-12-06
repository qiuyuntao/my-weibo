//
//  WBUser.h
//  my-weibo
//
//  Created by qyt on 12/6/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject

@property (nonatomic, copy) NSString *idstr; // 用户ID
@property (nonatomic, copy) NSString *name; // 用户昵称
@property (nonatomic, copy) NSString *profile_image_url; // 用户头像

@end
