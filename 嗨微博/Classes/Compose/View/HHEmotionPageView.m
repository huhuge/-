//
//  HHEmotionPageView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//


#import "HHEmotionPageView.h"
#import "HHEmotion.h"

@implementation HHEmotionPageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] init];
//        btn.backgroundColor = HHRandomColor;
        HHEmotion *emotion = emotions[i];
        if (emotion.png) { // 有图片
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        } else if (emotion.code) { // emoji表情
            // emotion.code : 16进制 转字符串
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }

        [self addSubview:btn];
        
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat inset = 10; // 内边距
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / HHEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / HHEmotionMaxRows;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%HHEmotionMaxCols) * btnW;
        btn.y = inset + (i/HHEmotionMaxCols) * btnH;
        
    }

}

@end
