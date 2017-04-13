//
//  HHStatus.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/8.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHStatus.h"
#import "HHUser.h"
#import "MJExtension.h"
#import "HHPhoto.h"

@implementation HHStatus

- (NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [HHPhoto class]};
}

/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */

// set方法
- (void)setCreated_at:(NSString *)created_at{
    
    _created_at = created_at;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 是今年
        if ([createDate isYestoday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            _created_at = [fmt stringFromDate:createDate];
        } else if ([createDate isToday]){ // 今天
            if (cmps.hour >= 1) {
                _created_at = [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            } else if (cmps.minute >= 1) {
                _created_at = [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            } else {
                _created_at = @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            _created_at = [fmt stringFromDate:createDate];
        }
        
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        _created_at = [fmt stringFromDate:createDate];
    }
}

// get方法
//- (NSString *)created_at{
//    
//}

// <a href="http://weibo.com/" rel="nofollow">达人的iPhone</a>
- (void)setSource:(NSString *)source{
    if (source.length) { // 有来源
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
    }
    //没有来源不做任何处理
}

@end
