//
//  HHEmotionPageView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//


#import "HHEmotionPageView.h"
#import "HHEmotion.h"
#import "HHEmotionPopView.h"
#import "HHEmotionButton.h"

@interface HHEmotionPageView();

/** 点击按钮之后弹出的放大镜 */
@property (nonatomic, strong) HHEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteBtn;

@end

@implementation HHEmotionPageView

- (HHEmotionPopView *)popView{
    if (!_popView) {
        self.popView = [HHEmotionPopView popView];
    }
    return _popView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.删除按钮
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
        // 2.添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

#pragma mark ------定位手指下面的按钮------
- (HHEmotionButton *)emotionButtonWithLocation:(CGPoint)location{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        HHEmotionButton *btn = self.subviews[i+1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}



#pragma mark ------长按手势监听------
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer{
    
    CGPoint location = [recognizer locationInView:recognizer.view];
    HHEmotionButton *btn = [self emotionButtonWithLocation:location];

    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:     // 手指已经不再触摸pageView
        {
            // 移除popView
            [self.popView removeFromSuperview];
            
            // 手指在按钮上
            if (btn) {
                // 发出通知
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[HHSelectEmotionKey] = btn.emotion;
                [HHNotificationCenter postNotificationName:HHEmotionDidSelectNotification object:nil userInfo:userInfo];
            }
              break;
        }
        case UIGestureRecognizerStateBegan:  // 手势开始
            
            break;
        case UIGestureRecognizerStateChanged: // 手指位置改变
        {
            [self.popView showFrom:btn];
            break;
        }
        default:
            break;
    }
}


#pragma mark ------监听删除按钮------
- (void)deleteClick{
    [HHNotificationCenter postNotificationName:HHEmotionDidDeleteNotification object:nil userInfo:nil];
}


- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        HHEmotionButton *btn = [[HHEmotionButton alloc] init];
        
        // 设置表情数据
        btn.emotion = emotions[i];
        // 监听点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

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
        UIButton *btn = self.subviews[i+1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%HHEmotionMaxCols) * btnW;
        btn.y = inset + (i/HHEmotionMaxCols) * btnH;
        
    }
    
    // 删除按钮
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.y = self.height - btnH;
    self.deleteBtn.x = self.width -inset - btnW;
}

#pragma mark ------表情点击事件------
- (void)btnClick:(HHEmotionButton *)sender{
    
    // 显示popView
    [self.popView showFrom:sender];
    
    // 让popView消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[HHSelectEmotionKey] = sender.emotion;
    [HHNotificationCenter postNotificationName:HHEmotionDidSelectNotification object:nil userInfo:userInfo];
}

@end
