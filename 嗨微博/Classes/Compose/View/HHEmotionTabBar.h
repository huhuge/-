//
//  HHEmotionTabBar.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/14.
//  Copyright © 2017年 huhuge. All rights reserved.
// 表情键盘底部选项卡

#import <UIKit/UIKit.h>

typedef enum {
    HHEmotionTabBarButtonTypeRecent,    // 最近
    HHEmotionTabBarButtonTypeDefault,   // 默认
    HHEmotionTabBarButtonTypeEmoji,     // emoji
    HHEmotionTabBarButtonTypeLxh        // 浪小花
} HHEmotionTabBarButtonType;

@class HHEmotionTabBar;

@protocol HHEmotionTabBarDelegate <NSObject>

@optional

- (void)emotionTabBar:(HHEmotionTabBar *)tabBar didSelectButton:(HHEmotionTabBarButtonType)buttonTpye;

@end

@interface HHEmotionTabBar : UIView
@property (nonatomic, weak) id<HHEmotionTabBarDelegate> delegate;
@end
