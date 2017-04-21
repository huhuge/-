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
@end
