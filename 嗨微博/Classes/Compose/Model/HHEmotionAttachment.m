//
//  HHEmotionAttachment.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/20.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHEmotionAttachment.h"
#import "HHEmotion.h"

@implementation HHEmotionAttachment

- (void)setEmotion:(HHEmotion *)emotion{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];    

}

@end
