//
//  HHDropdownMenu.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHDropdownMenu;

@protocol HHDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismissed:(HHDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(HHDropdownMenu *)menu;

@end

@interface HHDropdownMenu : UIView

@property (nonatomic, weak) id<HHDropdownMenuDelegate> delegate;

+ (instancetype)menu;


/**
 *  显示
 */
- (void)showFrom:(UIView *)from;

/**
 *  销毁
 */
- (void)dismiss;


/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;

/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
