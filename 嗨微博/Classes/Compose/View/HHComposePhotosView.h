//
//  HHComposePhotosView.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/14.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;
@property (nonatomic, strong, readonly) NSMutableArray *photos;
//- (NSArray *)photos;
@end
