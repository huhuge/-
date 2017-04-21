//
//  HHEmotionListView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/14.
//  Copyright © 2017年 huhuge. All rights reserved.
// 表情键盘顶部表情内容

#import "HHEmotionListView.h"
#import "HHEmotionPageView.h"

@interface HHEmotionListView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HHEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
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
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 删除之前的控件
    NSUInteger count = (emotions.count + HHEmotionPageSize - 1) / HHEmotionPageSize;
    
    // 1.设置页数
    self.pageControl.numberOfPages = count;
    
    
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i < count; i++) {
        HHEmotionPageView *pageView = [[HHEmotionPageView alloc] init];
//        pageView.backgroundColor = HHRandomColor;
    
        // 设置该也表情
        NSRange range;
        range.location = i * HHEmotionPageSize;
        
        // 剩下个数
        NSUInteger left = emotions.count - range.location;
        if (left >= HHEmotionPageSize) { // 剩下的大于20个
            range.length = HHEmotionPageSize;
        } else { // 剩下不足20个
            range.length = left;
        }
        
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
        
    }
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.UIPageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        HHEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = ScreenW;
        pageView.x = pageView.width * i;
        pageView.y = 0;

    }
    
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo +0.5);
}


@end
