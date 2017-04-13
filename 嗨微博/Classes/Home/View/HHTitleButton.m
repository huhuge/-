//
//  HHTitleButton.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/7.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#define HHMargin 5

#import "HHTitleButton.h"

@implementation HHTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        self.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        

    }
    return self;
}


//- (void)setFrame:(CGRect)frame{
//    frame.size.width += HHMargin;
//    [super setFrame:frame];
//}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 1.计算label的frame
    self.titleLabel.x = self.imageView.x;
    
    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + HHMargin;

}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
