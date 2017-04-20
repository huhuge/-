//
//  HHEmotionButton.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHEmotionButton.h"
#import "HHEmotion.h"

@implementation HHEmotionButton


// 当控件不是从xib、storyboard中创建是时，就会调用这个方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

// 当控件从xib、storyboard中创建是时，就会调用这个方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

// 这个方法会在initWithCoder：方法调用后再调用
- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setEmotion:(HHEmotion *)emotion{
    _emotion = emotion;
    if (emotion.png) { // 有图片
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) { // emoji表情
        // emotion.code : 16进制 转字符串
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }

}

#pragma mark ------单独抽出初始换方法------
- (void)setup{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    
    // 高亮是不要变灰色
    self.adjustsImageWhenHighlighted = NO;
//    self.adjustsImageWhenDisabled
}


@end
