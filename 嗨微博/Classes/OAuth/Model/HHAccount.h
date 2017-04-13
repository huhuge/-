//
//  HHAccount.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/7.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHAccount : NSObject<NSCoding>
/**
 *  用于调用access_token,接口获取授权后的access_token
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  access_token的生命周期，单位是秒数
 */
@property (nonatomic, copy) NSNumber *expires_in;

/**
 *  弃用
 */
//@property (nonatomic, copy) NSString *remind_in;

/**
 *  当前授权用户的UID
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  账号创建时间（token获得时间）
 */
@property (nonatomic, strong) NSDate *create_time;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
