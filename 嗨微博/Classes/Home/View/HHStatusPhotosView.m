//
//  HHStatusPhotosView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/12.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHStatusPhotosView.h"
#import "HHPhoto.h"
#import "HHStatusPhotoView.h"

// 每张配图的宽高
#define HHStatusPhotoMargin 10
#define HHStatusPhotosWH (ScreenW - HHStatusPhotoMargin * 4) / 3

#define HHStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation HHStatusPhotosView




- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    NSInteger photosCount = photos.count;
    while (self.subviews.count < photosCount) {
        HHStatusPhotoView *photoView = [[HHStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历图片控件
    for (int i = 0; i < self.subviews.count; i++) {
        HHStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) {
            photoView.photo = photos[i];
            
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger photosCount = self.photos.count;
    NSInteger macCol = HHStatusPhotoMaxCol(photosCount);

    for (int i = 0; i < photosCount; i++) {
        HHStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % macCol;
        photoView.x = col * (HHStatusPhotosWH + HHStatusPhotoMargin);
        
        int row = i / macCol;
        photoView.y = row * (HHStatusPhotosWH + HHStatusPhotoMargin);
        photoView.width  = HHStatusPhotosWH;
        photoView.height = HHStatusPhotosWH;
    }
}

+ (CGSize)SizeWithCount:(NSInteger)count{
    
    NSInteger maxCols = HHStatusPhotoMaxCol(count);
    // 列数
    NSInteger cols = (count >= maxCols) ? maxCols : count;
    CGFloat photosW = cols * HHStatusPhotosWH + (cols - 1) * HHStatusPhotoMargin;
    
    
    // 行数
    NSInteger rows = (count + maxCols - 1) / maxCols;
    
    CGFloat photosH = rows * HHStatusPhotosWH + (rows - 1) * HHStatusPhotoMargin;
    return CGSizeMake(photosW, photosH);
    
}

@end
