//
//  OAuthAccount.h
//  my-weibo
//
//  Created by qyt on 11/24/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthAccount : NSObject <NSObject>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

+ (instancetype)accoutWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
