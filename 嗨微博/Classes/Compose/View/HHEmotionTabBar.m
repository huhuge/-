//
//  HHEmotionTabBar.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/14.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHEmotionTabBar.h"
#import "HHEmotionTabBarButton.h"

@interface HHEmotionTabBar();

@property (nonatomic, weak) HHEmotionTabBarButton *selectedBtn;

@end

@implementation HHEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setupBtn:NSLocalizedString(@"recent", nil) buttonType:HHEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"最近" buttonType:HHEmotionTabBarButtonTypeRecent];
//        [self btnClick:[self setupBtn:@"默认" buttonType:HHEmotionTabBarButtonTypeDefault]];
        [self setupBtn:@"默认" buttonType:HHEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:HHEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:HHEmotionTabBarButtonTypeLxh];
        
    }
    return self;
}

// 创建按钮
- (HHEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(HHEmotionTabBarButtonType)btnType{
    HHEmotionTabBarButton *btn = [[HHEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:title forState:UIControlStateNormal];
        
    NSString *image = nil;
    NSString *highImage = nil;
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        highImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        highImage = @"compose_emotion_table_right_selected";
    } else {
        image = @"compose_emotion_table_mid_normal";
        highImage = @"compose_emotion_table_mid_selected";

    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateDisabled];
    btn.tag = btnType;
    [self addSubview:btn];
    
    // 选中默认
//    if (btnType == HHEmotionTabBarButtonTypeDefault) {
//        [self btnClick:btn];
//    }
    
    return btn;
}

-(void)layoutSubviews{
    
    int count = (int)self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        HHEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }

}


- (void)setDelegate:(id<HHEmotionTabBarDelegate>)delegate{
    _delegate = delegate;
    
    // 选中“默认按钮”
    [self btnClick:[self viewWithTag:HHEmotionTabBarButtonTypeDefault]];
}

// 按钮点击
- (void)btnClick:(HHEmotionTabBarButton *)sender{
    self.selectedBtn.enabled = YES;
    sender.enabled    = NO;
    self.selectedBtn = sender;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(HHEmotionTabBarButtonType)sender.tag];
    }
    
}

@end
