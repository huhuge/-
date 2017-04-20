//
//  HHEmotionPopView.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHEmotion,HHEmotionButton;

@interface HHEmotionPopView : UIView

+ (instancetype)popView;

- (void)showFrom:(HHEmotionButton *)button;

@end
