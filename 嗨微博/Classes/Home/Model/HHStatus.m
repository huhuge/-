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
#import "RegexKitLite.h"
#import "HHUser.h"
#import "HHTextPart.h"
#import "HHEmotion.h"
#import "HHEmotionTool.h"
#import "HHSpecial.h"

@implementation HHStatus

- (NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [HHPhoto class]};
}


- (NSAttributedString *)attributedTextWithText:(NSString *)text{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    NSString *emotionPattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]"; // 表情规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";  // @规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";  // 话题规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))"; // 链接规则
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emotionPattern,atPattern,topicPattern,urlPattern];
    
    // 遍历特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if ((*capturedRanges).length == 0) return ;
        HHTextPart *part = [[HHTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 遍历所有非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return ;

        HHTextPart *part = [[HHTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];

    }];
    
    
    
    // 排序
    [parts sortUsingComparator:^NSComparisonResult(HHTextPart *part1, HHTextPart *part2) {
//        NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
        
    }];
    
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableArray *specials = [NSMutableArray array];
    // 按顺序拼接所有内容
    for (HHTextPart *part in parts) {
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            NSString *name = [HHEmotionTool emotionWithChs:part.text].png;
            if (name) { //能找到图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else {
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
            

        } else if (part.special) { // 特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{NSForegroundColorAttributeName:HHRGBColor(82, 126, 176)}];
            // 创建特殊对象
            HHSpecial *s = [[HHSpecial alloc] init];
            s.text = part.text;

            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            [specials addObject:s];
            
        } else { // 非特殊
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    return attributedText;
}

-(void)setText:(NSString *)text{
    _text = text;
    // 利用text生成attributedText
   
    self.attributedText = [self attributedTextWithText:text];
}


- (void)setRetweeted_status:(HHStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name,retweeted_status.text];

    self.retweetedAttributedText = [self attributedTextWithText:retweetContent];
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
    } else { // 没有来源不做任何处理
//        _source = @"来自新浪微博";
    }
    
}

@end
