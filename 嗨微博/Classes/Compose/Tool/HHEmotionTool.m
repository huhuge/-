
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
#import "MJExtension.h"


@implementation HHEmotionTool

static NSMutableArray *_recentEmotions;


+ (void)initialize{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HHRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }

}



+ (HHEmotion *)emotionWithChs:(NSString *)chs{
    NSArray *defaults = [self defaultEmotions];
    for (HHEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    
    NSArray *lxh = [self lxhEmotions];
    for (HHEmotion *emotion in lxh) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    
    return nil;
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

static NSArray *_emojiEmotions, *_defaultEmotions, *_lxhEmotions;

+ (NSArray *)recentEmotions{
    
    return _recentEmotions;
}

+ (NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [HHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotions;

}

+ (NSArray *)emojiEmotions{
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [HHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }    return _emojiEmotions;

}

+ (NSArray *)lxhEmotions{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [HHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }    return _lxhEmotions;
}

@end
