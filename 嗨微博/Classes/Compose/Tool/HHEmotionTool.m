
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



@implementation HHEmotionTool

/** 存入数组 */
+ (void)addRecentEmotion:(HHEmotion *)emotion{
    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
    if (emotions == nil) {
        emotions = [NSMutableArray array];
    }
    
    [emotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:emotions toFile:HHRecentEmotionsPath];
}


/** 返回装置HHEmotion模型的数组 */
+ (NSArray *)recentEmotions{
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:HHRecentEmotionsPath];
}

@end
