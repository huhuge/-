//
//  HHDropdownMenu.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHDropdownMenu.h"

@interface HHDropdownMenu()

@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation HHDropdownMenu


- (UIImageView *)containerView{
    if (!_containerView) {
        //灰色图片
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.height = 217;
        containerView.width = 217;
        containerView.y = 40;
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;

    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //颜色
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

+ (instancetype)menu{
    
    return [[self alloc] init];
}

- (void)setContent:(UIView *)content{
    _content = content;
    
    //调整内容位置
    content.x = 10;
    content.y = 15;
    
    //调整内容的宽度
//    content.width = self.containerView.width - 2 * content.x;
    
    // 设置灰色图片尺寸
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    //添加内容到灰色view
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController{
    
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)showFrom:(UIView *)from{
    
    //获取最上面窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //添加自己到窗口上
    [window addSubview:self];
    
    //设置尺寸
    self.frame = window.bounds;
    
    //调整灰色图片的位置
    //转换坐标系计算高度
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.centerX = CGRectGetMidX(newFrame);
    
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

- (void)dismiss{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismissed:)]) {
        [self.delegate dropdownMenuDidDismissed:self];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}








@end
