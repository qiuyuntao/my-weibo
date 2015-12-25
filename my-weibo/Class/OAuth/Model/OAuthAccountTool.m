//
//  OAuthAccountTool.m
//  my-weibo
//
//  Created by qyt on 12/25/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "OAuthAccountTool.h"
#import "OAuthAccount.h"

#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation OAuthAccountTool

+ (void)saveAccount:(OAuthAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFile];
}

+ (OAuthAccount *)account {
    // 取出账号
    OAuthAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];

    return account;
}

@end
