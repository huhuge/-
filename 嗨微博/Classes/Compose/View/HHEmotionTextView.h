//
//  HHEmotionTextView.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHTextView.h"
@class HHEmotion;

@interface HHEmotionTextView : HHTextView

- (void)insertEmotion:(HHEmotion *)emotion;

- (NSString *)fullText;
@end
