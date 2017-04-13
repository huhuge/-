//
//  AppDelegate.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "AppDelegate.h"
#import "HHOAuthVC.h"
#import "HHAccount.h"
#import "HHAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.设置控制器
    HHAccount *account = [HHAccountTool account];
    
    if (account) { // 登录过
        [self.window switchRootViewController];
    } else { // 没有登录
        self.window.rootViewController = [[HHOAuthVC alloc] init];
    }
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请的后台运行时间已经结束（过期），就会调用这个block
        
        // 赶紧结束任务
        [application endBackgroundTask:task];
    }];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];

    // 1.取消下载
    [mgr cancelAll];
    
    
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
    
}


@end
