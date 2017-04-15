//
//  HHEmotionTabBarButton.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/15.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHEmotionTabBarButton.h"

@implementation HHEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];

        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
