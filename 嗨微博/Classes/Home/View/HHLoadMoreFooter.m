//
//  HHLoadMoreFooter.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/9.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHLoadMoreFooter.h"

@implementation HHLoadMoreFooter

+ (instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"HHLoadMoreFooter" owner:nil options:nil]lastObject];
}


@end
