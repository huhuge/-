//
//  HHTabbarVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHTabbarVC.h"
#import "HHHomeVC.h"
#import "HHMessageCenterVC.h"
#import "HHDiscoverVC.h"
#import "HHProfileVC.h"
#import "HHNavigationController.h"
#import "HHTabbar.h"
#import "HHComposeVC.h"


@interface HHTabbarVC ()<HHTabbarDelegate>

@end

@implementation HHTabbarVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
    //1.设置子控制器
    HHHomeVC *home = [[HHHomeVC alloc] init];
    [self addChildVC:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    HHMessageCenterVC *messageCenter = [[HHMessageCenterVC alloc] init];
    [self addChildVC:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    
    HHDiscoverVC *discover = [[HHDiscoverVC alloc] init];
    [self addChildVC:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    HHProfileVC *profile = [[HHProfileVC alloc] init];
    [self addChildVC:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

    // 2.更换系统自带的tabbar
//    self.tabBar = [[HHTabbar alloc] init];
    HHTabbar *tabBar = [[HHTabbar alloc] init];
    tabBar.myDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
        
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selImage{
    
    //设置子控制器
//    childVC.tabBarItem.title = title;//设置tabbar的文字
//    childVC.navigationItem.title = title;//设置navigation的文字
    childVC.title = title; // 同时设置tabbar和navigation的文字
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    //显示原始图片
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVC.view.backgroundColor = HHRandomColor;
    //设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HHRGBColor(123, 123, 123);
    NSMutableDictionary *selTextAttrs = [NSMutableDictionary dictionary];
    selTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selTextAttrs forState:UIControlStateSelected];
    
    //先包装导航控制器
    HHNavigationController *nav = [[HHNavigationController alloc] initWithRootViewController:childVC];
    
    //添加为子控制器
    [self addChildViewController:nav];
    
}

// modal一个新VC
- (void)tabbarDidClickPlusButton:(HHTabbar *)tabBar{
    HHComposeVC *compose = [[HHComposeVC alloc] init];
    
    HHNavigationController *nav = [[HHNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
