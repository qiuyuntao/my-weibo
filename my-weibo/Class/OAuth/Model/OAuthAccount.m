//
//  OAuthAccount.m
//  my-weibo
//
//  Created by qyt on 11/24/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "OAuthAccount.h"

@implementation OAuthAccount

+ (instancetype)accoutWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    [self setValuesForKeysWithDictionary:dict];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
}

@end
