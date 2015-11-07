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

