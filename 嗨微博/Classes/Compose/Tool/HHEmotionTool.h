//
//  HHEmotionTool.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/20.
//  Copyright © 2017年 huhuge. All rights reserved.
//



#import <Foundation/Foundation.h>
@class HHEmotion;
@interface HHEmotionTool : NSObject

+ (void)addRecentEmotion:(HHEmotion *)emotion;

+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)emojiEmotions;
+ (NSArray *)lxhEmotions;

/**
 通过表情描述找到表情名
 */
+ (HHEmotion *)emotionWithChs:(NSString *)chs;
@end
