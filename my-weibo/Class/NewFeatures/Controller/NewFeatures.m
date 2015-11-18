//
//  NewFeatures.m
//  my-weibo
//
//  Created by qyt on 11/16/15.
//  Copyright © 2015 qyt. All rights reserved.
//

#import "NewFeatures.h"
#import "NewFeaturesPageControl.h"
#import "UIImage+my_weibo.h"

@interface NewFeatures () <UIScrollViewDelegate>

@property (nonatomic, weak)NewFeaturesPageControl *pageControl;

@end

@implementation NewFeatures

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initForScrollView];
    
    [self initForPageControl];
}

- (void)initForScrollView {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.frame;
    
    for (int i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        if (self.view.frame.size.height >= 568) {
            imageName = [imageName stringByAppendingString:@"-568h"];
            NSLog(@"%@", imageName);
        }
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageWithOS7:imageName]];
        view.frame = CGRectMake(i * self.view.frame.size.width, 0, scroll.frame.size.width, scroll.frame.size.height);
        [scroll addSubview:view];
    }
    scroll.contentSize = CGSizeMake(scroll.frame.size.width * 3, scroll.frame.size.height);
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.delegate = self;
    
    [self.view addSubview: scroll];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float width = self.view.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    float pageNumber = (int)((x / width) + 0.5);
    
    self.pageControl.currentPage = pageNumber;
}

- (void)initForPageControl {
    NewFeaturesPageControl *pageControl = [[NewFeaturesPageControl alloc] init];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 30);
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1 green:0.47 blue:0.22 alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.79 green:0.79 blue:0.79 alpha:1];
    self.pageControl = pageControl;
    
    [self.view addSubview:pageControl];
}

@end
