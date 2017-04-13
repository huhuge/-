//
//  NSDate+Extension.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/11.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

// 判断是否同一年
- (BOOL)isThisYear;
// 判断是不是昨天
- (BOOL)isYestoday;
// 判断是不是今天
- (BOOL)isToday;

@end
