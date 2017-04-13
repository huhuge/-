//
//  HHAccountTool.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/7.
//  Copyright © 2017年 huhuge. All rights reserved.
//

// 账号存储路径
#define HHAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "HHAccountTool.h"

@implementation HHAccountTool

/**
 *   存储账号信息
 */
+ (void)saveAccount:(HHAccount *)account{
    
    // 自定义对象的存储必须用NSKeyedArchiver，不用writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:HHAccountPath];

}

/**
 *  返回账号模型，如果账号过期返回nil
 */
+ (HHAccount *)account{
    //加载模型
    HHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HHAccountPath];
    
    //验证账号是否过期
    long long expires_in =  [account.expires_in longLongValue];
    
    // 获取过期时间
    NSDate *expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    return account;
    
}


@end
