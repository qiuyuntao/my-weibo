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

* 加载url图片
	* [引入SDWebImage](https://github.com/rs/SDWebImage) 
	* 它会自动的启动多线程来加载图片，以及cache

	```
	#import "UIImageView+WebCache.h"
	[cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
	```

#### 计算大小
* 计算字体占据大小

```
NSString *badgeValue = @"123";
CGFloat width = [badgeValue sizeWithAttributes:@{@NSFontAttributeName: self.titleLabel.font}].width;
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

#### 数据相关

* 讲数据对象存储为数据字典
```
{
    "access_token" = "2.00fzxwTC0Dslm666b918bfa5vjkRBC";
    "expires_in" = 157679999;
    "remind_in" = 157679999;
    uid = 2274833051;
}
```

```
// 声明成员变量
#import <Foundation/Foundation.h>

@interface OAuthAccount : NSObject <NSObject>

@property (nonatomic, assign) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

+ (instancetype)accoutWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
```

```
// 在对于的.m文件中实现相应的方法，进行赋值
// json里的数据必须一一对于头文件里创建的数据的变量名
+ (instancetype)accoutWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    [self setValuesForKeysWithDictionary:dict];
    
    return self;
}
```




















