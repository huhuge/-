//
//  HHStatus.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/8.
//  Copyright © 2017年 huhuge. All rights reserved.
// 微博状态模型

#import <Foundation/Foundation.h>

@class HHUser;

@interface HHStatus : NSObject

/** 字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;

/** 微博信息内容 */
@property (nonatomic, copy) NSString *text;

/** 微博创建时间 */
@property (nonatomic, copy) NSString *created_at;

/** 微博信息来源 */
@property (nonatomic, copy) NSString *source;

/** 微博作者的用户信息字段 */
@property (nonatomic, strong) HHUser *user;

/** 微博配图地址，多图时返回多图链接，无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;

/** 转发微博对象 */
@property (nonatomic, strong) HHStatus *retweeted_status;



/** int 转发数 */
@property (nonatomic, assign) int reposts_count;

/**	int 评论数 */
@property (nonatomic, assign) int comments_count;

/**	int 表态数 */
@property (nonatomic, assign) int attitudes_count;



@end
