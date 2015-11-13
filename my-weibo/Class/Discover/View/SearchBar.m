//
//  SearchBar.m
//  my-weibo
//
//  Created by qyt on 11/9/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "SearchBar.h"
#import "UIImage+my_weibo.h"

@interface SearchBar()

@property (nonatomic, weak)UIImageView *leftIcon;

@end

@implementation SearchBar

+ (SearchBar *)initSearchBar {
    SearchBar *input = [[SearchBar alloc] init];
    input.background = [UIImage resizeImage:@"searchbar_textfield_background"];
    input.font = [UIFont systemFontOfSize:13];
    
    UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageWithOS7:@"searchbar_textfield_search_icon"]];
    input.leftView = leftIcon;
    input.leftViewMode = UITextFieldViewModeAlways;
    leftIcon.contentMode = UIViewContentModeCenter;
    input.leftIcon = leftIcon;
    
    input.placeholder = @"搜索";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    input.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:dict];
    
    input.clearButtonMode = UITextFieldViewModeAlways;
    
    input.returnKeyType = UIReturnKeySearch;
    
    return input;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftIcon.frame = CGRectMake(0, 0, 30, self.frame.size.height);
}


@end
