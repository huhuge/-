//
//  UIWindow+Extension.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/7.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HHTabbarVC.h"
#import "HHNewFeatureVC.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController{
    
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    if ([lastVersion isEqualToString:currentVersion]) {// 版本一样
        
        self.rootViewController = [[HHTabbarVC alloc] init];
        
    } else {// 版本不一样
        
        self.rootViewController = [[HHNewFeatureVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

@end
