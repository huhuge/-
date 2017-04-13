//
//  HHStatusPhotoView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/12.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHStatusPhotoView.h"
#import "HHPhoto.h"

@interface HHStatusPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation HHStatusPhotoView

- (UIImageView *)gifView{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


- (void)setPhoto:(HHPhoto *)photo{
    _photo = photo;
    /*
    UIViewContentModeScaleToFill ： 图片拉伸至填充整个imageView
    UIViewContentModeScaleAspectFit ：图片拉伸至完全显示在imageView里面，不会变形
    UIViewContentModeScaleAspectFill ： 图片拉伸到填充满真个imageView，然后显示最中间部分
    UIViewContentModeRedraw ： 调用setNeedsDisplay方法时，就会将图片重新渲染
    UIViewContentModeCenter ：居中显示
    UIViewContentModeTop 
    UIViewContentModeBottom,
    UIViewContentModeLeft,
    UIViewContentModeRight,
    UIViewContentModeTopLeft,
    UIViewContentModeTopRight,
    UIViewContentModeBottomLeft,
    UIViewContentModeBottomRight,
     
     **经验规律：
     1.凡是带有Scale单词的，图片都会拉伸
     2.凡是带有Aspect单词的，图片都会保持原来的宽高比，图片不会变形
     3.
     */
    
    self.backgroundColor = [UIColor redColor];
    
    //内容模式
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    //超出表框的都剪掉
    self.clipsToBounds = YES;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //把大写变成小写lowercaseString
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}


@end
