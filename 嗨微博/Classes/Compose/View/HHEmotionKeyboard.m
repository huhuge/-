//
//  HHEmotionKeyboard.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/14.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHEmotionKeyboard.h"
#import "HHEmotionTabBar.h"
#import "HHEmotionListView.h"
#import "HHEmotion.h"
#import "HHEmotionTool.h"

@interface HHEmotionKeyboard()<HHEmotionTabBarDelegate>

/** 保存正在显示的listView */
@property (nonatomic, weak) HHEmotionListView *showingListView;

/** 表情内容 */
@property (nonatomic, strong) HHEmotionListView *recentListView;
@property (nonatomic, strong) HHEmotionListView *defaultListView;
@property (nonatomic, strong) HHEmotionListView *emojiListView;
@property (nonatomic, strong) HHEmotionListView *lxhListView;

/** tabbar */
@property (nonatomic, weak) HHEmotionTabBar *tabBar;

@end

@implementation HHEmotionKeyboard

#pragma mark ------懒加载------

- (HHEmotionListView *)recentListView{
    if (!_recentListView) {
        self.recentListView = [[HHEmotionListView alloc] init];
        self.recentListView.emotions = [HHEmotionTool recentEmotions];
        
    }
    return _recentListView;
}

- (HHEmotionListView *)defaultListView{
    if (!_defaultListView) {
        self.defaultListView = [[HHEmotionListView alloc] init];
        self.defaultListView.emotions = [HHEmotionTool defaultEmotions];
    }
    return _defaultListView;
}

- (HHEmotionListView *)emojiListView{
    if (!_emojiListView) {
        self.emojiListView = [[HHEmotionListView alloc] init];
        self.emojiListView.emotions = [HHEmotionTool emojiEmotions];
    }
    return _emojiListView;
}

- (HHEmotionListView *)lxhListView{
    if (!_lxhListView) {
        self.lxhListView = [[HHEmotionListView alloc] init];
        self.lxhListView.emotions = [HHEmotionTool lxhEmotions];
    }
    return _lxhListView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        // tabbar
        HHEmotionTabBar *tabBar = [[HHEmotionTabBar alloc] init];
        tabBar.delegate = self;
//        tabBar.backgroundColor = [UIColor blueColor];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 监听表情选中通知
        // 选中表情通知
        [HHNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:HHEmotionDidSelectNotification object:nil];

    }
    return self;
}


- (void)emotionDidSelect{
    self.recentListView.emotions = [HHEmotionTool recentEmotions];
}

- (void)dealloc{
    [HHNotificationCenter removeObserver:self];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    // 1.tabar
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    
    // 3.设置frame
//    UIView *child = [self.subviews lastObject];
//    child.frame = self.bounds;

}

- (void)emotionTabBar:(HHEmotionTabBar *)tabBar didSelectButton:(HHEmotionTabBarButtonType)buttonTpye{
    
    // 移除上次加载的内容
    [self.showingListView removeFromSuperview];
    
    // 切换contentView内容
    switch (buttonTpye) {
        case HHEmotionTabBarButtonTypeRecent:{  // 最近
            // 加载沙盒中的数据
//            self.recentListView.emotions = [HHEmotionTool recentEmotions];
            [self addSubview:self.recentListView];
            break;
        }
        case HHEmotionTabBarButtonTypeDefault:{ // 默认
            [self addSubview:self.defaultListView];

          break;
        }
            
        case HHEmotionTabBarButtonTypeEmoji:{   // emoji
            [self addSubview:self.emojiListView];

            break;
        }
            
        case HHEmotionTabBarButtonTypeLxh: {   // 浪小花
            [self addSubview:self.lxhListView];

              break;
        }
           
            
        default:
            break;
    }
    self.showingListView = [self.subviews lastObject];
    // 重新计算子空间的frame
    [self setNeedsLayout];
}

@end
