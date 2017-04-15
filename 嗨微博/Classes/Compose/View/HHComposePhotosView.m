//
//  HHComposePhotosView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/14.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHComposePhotosView.h"

@interface HHComposePhotosView()


@end

@implementation HHComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}



- (void)addPhoto:(UIImage *)photo{
    UIImageView *photoView= [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    
    [self.photos addObject:photo];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger photosCount = self.subviews.count;
    NSInteger macCol = 3;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    for (int i = 0; i < photosCount; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % macCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / macCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width  = imageWH;
        photoView.height = imageWH;
    }

}

//- (NSArray *)photos{
//    return self.addedPhotos;
//}

//- (NSArray *)photos{
//    NSMutableArray *photos = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        [photos addObject:imageView.image];
//        
//    }
//    return photos;
//}

@end
