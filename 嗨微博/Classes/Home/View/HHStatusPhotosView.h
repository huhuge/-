//
//  HHStatusPhotosView.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/12.
//  Copyright © 2017年 huhuge. All rights reserved.
//cell的配图 里面放1~9张HHStatusPhotoView

#import <UIKit/UIKit.h>

@interface HHStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;

// 根据图片个数计算尺寸
+ (CGSize)SizeWithCount:(NSInteger)count;

@end
