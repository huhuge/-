//
//  HHStatusTool.h
//  嗨微博
//
//  Created by 胡明正 on 2017/5/2.
//  Copyright © 2017年 huhuge. All rights reserved.
// 微博工具类 ： 用来处理微博数据的缓存

#import <Foundation/Foundation.h>

@interface HHStatusTool : NSObject

/**
 根据请求参数去沙盒加载参数
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;

/**
 存储数据到沙盒中
 */
+ (void)saveStatuses:(NSArray *)statuses;

@end
