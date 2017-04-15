//
//  HHEmotionListView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/14.
//  Copyright © 2017年 huhuge. All rights reserved.
// 表情键盘顶部表情内容

// 每一页的表情个数
#define HHEmotionPageSize 20

#import "HHEmotionListView.h"

@interface HHEmotionListView()

@property (nonatomic, weak) UIScrollView *scrollowView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HHEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor yellowColor];
        [self addSubview:scrollView];
        self.scrollowView = scrollView;
        
        // 2.UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
        // 3.KVC设置圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];

        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

// 创建emotions
- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    // 1.设置页数
    self.pageControl.numberOfPages = (emotions.count + HHEmotionPageSize - 1) / HHEmotionPageSize;
    
    
    // 2.
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.UIPageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.
    self.scrollowView.width = self.width;
    self.scrollowView.height = self.pageControl.y;
    self.scrollowView.x = self.scrollowView.y = 0;
}

@end
