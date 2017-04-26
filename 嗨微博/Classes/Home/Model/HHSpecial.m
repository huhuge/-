//
//  HHSpecial.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/25.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHSpecial.h"

@implementation HHSpecial

- (NSString *)description{
    return [NSString stringWithFormat:@"%@---%@",self.text,NSStringFromRange(self.range)];
}

@end
