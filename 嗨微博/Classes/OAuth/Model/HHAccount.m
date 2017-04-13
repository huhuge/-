//
//  HHAccount.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/7.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHAccount.h"

@implementation HHAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    HHAccount *account   = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid          = dict[@"uid"];
    account.expires_in   = dict[@"expires_in"];
    // 获取账号存储的时间（token的产生时间）
    account.create_time  = [NSDate date];

    return account;
}

// 当对象要归档进沙盒时，就会调用这个方法，
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
    
}

// 从沙盒中加载一个对象是，会调用这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in   = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid          = [aDecoder decodeObjectForKey:@"uid"];
        self.create_time  = [aDecoder decodeObjectForKey:@"create_time"];
        self.name         = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
