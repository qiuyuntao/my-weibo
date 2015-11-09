my-weibo
--

#### 自定义button
* 自定义图片位置

```
// 自定义图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 0, imageW, imageH);
}

```

* 自定义文字位置

```
// 自定义文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * 0.4;
    return CGRectMake(0, contentRect.size.height * 0.6, titleW, titleH);
}
```

* 长按按钮

```
// 去除自带的长按效果
- (void)setHighlighted:(BOOL)highlighted {}
```

#### 图片相关 UIImage
* 拉伸图片

```
// 拉伸图片
+ (UIImage *)resizeImage:(NSString *)name {
    UIImage *image = [UIImage imageWithOS7:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
```

#### 计算大小
* 计算字体占据大小

```
NSString *badgeValue = @"123";
CGFloat width = [badgeValue sizeWithAttributes:@{@"NSFontAttributeName": self.titleLabel.font}].width;
```

#### 自定义导航栏 NavViewController
* 自定义导航栏 取出导航栏以及按钮

```
UINavigationBar *navBar = [UINavigationBar appearance];
UIBarButtonItem *item = [UIBarButtonItem appearance];
    
``` 

* push 时候取消tabBar的显示

```
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:YES];
}
```