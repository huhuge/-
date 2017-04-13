//
//  HHTabbar.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/5.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHTabbar;

//必须继承UITabBarDelegate
@protocol HHTabbarDelegate <UITabBarDelegate>

@optional

- (void)tabbarDidClickPlusButton:(HHTabbar *)tabBar;

@end

@interface HHTabbar : UITabBar
@property (nonatomic, weak) id<HHTabbarDelegate> myDelegate;

@end
