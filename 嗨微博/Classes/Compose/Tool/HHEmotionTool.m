
//
//  HHEmotionTool.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/20.
//  Copyright © 2017年 huhuge. All rights reserved.
//

// 最近表情存储路径
#define HHRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "HHEmotionTool.h"
#import "HHEmotion.h"


@implementation HHEmotionTool

static NSMutableArray *_recentEmotions;


+ (void)initialize{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HHRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }

}

/** 存入数组 */
+ (void)addRecentEmotion:(HHEmotion *)emotion{
    // 删除重复表情
//    for (HHEmotion *e in emotions) {
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code] ) {
//            [emotions removeObject:e];
//            break;
//        }
//    }
    
    [_recentEmotions removeObject:emotion];
    
    if (_recentEmotions.count == 20) { // 限制数组长度
        [_recentEmotions removeLastObject];
    }
    
    [_recentEmotions insertObject:emotion atIndex:0];
//    [emotions removeAllObjects];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:HHRecentEmotionsPath];
}


/** 返回装置HHEmotion模型的数组 */
+ (NSArray *)recentEmotions{
    
    return _recentEmotions;
}

@end
