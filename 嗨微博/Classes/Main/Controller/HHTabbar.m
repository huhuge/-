//
//  HHTabbar.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/5.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHTabbar.h"

@interface HHTabbar()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation HHTabbar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;

    }
    return self;
}

- (void)plusClick{
    if ([self.myDelegate respondsToSelector:@selector(tabbarDidClickPlusButton:)]) {
        [self.myDelegate tabbarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width/2;
    self.plusBtn.centerY = self.height/2;
    
    
    // 2.设置其他tabbarButton的位置和尺寸
    CGFloat tabbarBtnW = self.width / 5;
    CGFloat tabbarBtnIndex = 0;
    NSInteger count = self.subviews.count;
//    HLog(@"%ld",(long)count);

    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = self.width / count;
            child.x = tabbarBtnIndex * tabbarBtnW;
            tabbarBtnIndex++;
            if (tabbarBtnIndex == 2) {
                tabbarBtnIndex++;
            }
        }

    }
}





@end
