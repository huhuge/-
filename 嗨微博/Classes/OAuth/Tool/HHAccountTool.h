//
//  HHAccountTool.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/7.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHAccount.h"

@interface HHAccountTool : NSObject

/**
 *  存储账号信息
 */
+ (void)saveAccount:(HHAccount *)account;

/**
 *  返回账号模型，如果账号过期返回nil
 */
+ (HHAccount *)account;

@end
