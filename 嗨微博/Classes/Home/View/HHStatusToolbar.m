//
//  HHStatusToolbar.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/11.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHStatusToolbar.h"
#import "HHStatus.h"

@interface HHStatusToolbar()

/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;


@end

@implementation HHStatusToolbar

- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}


+ (instancetype)toolbar{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.repostBtn = [self setupButton:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupButton:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupButton:@"点赞" icon:@"timeline_icon_unlike"];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

#pragma mark ------设置分割线------
- (void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}


#pragma mark ------初始化按钮------
- (UIButton *)setupButton:(NSString *)title icon:(NSString *)icon{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    int count = (int)self.btns.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
    
    // 设置分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }

}

- (void)setStatus:(HHStatus *)status{
    _status = status;
//    status.reposts_count = 85893;
//    status.comments_count = 10003;
//    status.attitudes_count = 494;
    [self setupBtnCount:status.reposts_count title:@"转发" btn:self.repostBtn];
    [self setupBtnCount:status.comments_count title:@"评论" btn:self.commentBtn];
    [self setupBtnCount:status.attitudes_count title:@"赞" btn:self.attitudeBtn];
    

}

#pragma mark ------设置按钮title------
- (void)setupBtnCount:(int)count title:(NSString *)title btn:(UIButton *)sender {
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        } else {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
 
    }
    [sender setTitle:title forState:UIControlStateNormal];

}



@end
