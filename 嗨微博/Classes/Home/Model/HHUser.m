//
//  HHUser.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/8.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHUser.h"

@implementation HHUser

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

//- (BOOL)isVip{
//    return self.mbrank > 2;
//}

@end
