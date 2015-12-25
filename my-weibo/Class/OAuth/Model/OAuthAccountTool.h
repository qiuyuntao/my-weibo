//
//  OAuthAccountTool.h
//  my-weibo
//
//  Created by qyt on 12/25/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OAuthAccount;

@interface OAuthAccountTool : NSObject

+ (void)saveAccount:(OAuthAccount *)account;
+ (OAuthAccount *)account;

@end
