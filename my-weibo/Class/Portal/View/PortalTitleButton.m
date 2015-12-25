//
//  PortalTitleButton.m
//  my-weibo
//
//  Created by qyt on 11/13/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "PortalTitleButton.h"
#import "UIImage+my_weibo.h"

@implementation PortalTitleButton

- (instancetype)init {
    self = [super init];
    [self setImage:[UIImage imageWithOS7:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.adjustsImageWhenHighlighted = NO;
    
    [self addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchDown];
    
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    CGFloat width = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    self.frame = CGRectMake(0, 0, width + 20, 40);
}

- (void)titleClick {
    if ([self.currentImage isEqual:[UIImage imageWithOS7:@"navigationbar_arrow_down"]]) {
        [self setImage:[UIImage imageWithOS7:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageWithOS7:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width - 20;
    CGFloat h = self.frame.size.height;
    
    return CGRectMake(x, y, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat x = self.frame.size.width - 20;
    CGFloat y = 0;
    CGFloat w = 20;
    CGFloat h = 40;
    
    return CGRectMake(x, y, w, h);
}

@end
