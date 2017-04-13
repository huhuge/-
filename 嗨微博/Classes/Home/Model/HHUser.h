//
//  HHUser.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/8.
//  Copyright © 2017年 huhuge. All rights reserved.
// 用户模型

#import <Foundation/Foundation.h>

typedef enum {
    HHUserVerifiedTypeNone      = -1, // 没有任何认证
    HHUserVerifiedPersonal      = 0,  // 个人认证
    HHUserVerifiedOrgEnterprice = 2,  // 企业官方：CSDN、EOE、搜狐新闻客户端
    HHUserVerifiedOrgMedia      = 3,  // 媒体官方：程序员杂志、苹果汇
    HHUserVerifiedOrgWebsite    = 5,  // 网站官方：猫扑
    HHUserVerifiedDaren         = 220 // 微博达人
    
} HHUserVerifiedType;

@interface HHUser : NSObject
/** 用户id */
@property (nonatomic, copy) NSString *idstr;

/** 用户显示名称 */
@property (nonatomic, copy) NSString *name;

/** 用户头像地址 50 * 50 */
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 值大于2，才是会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/** 会员等级 */
@property (nonatomic, assign, getter = isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic, assign) HHUserVerifiedType verified_type;

@end
