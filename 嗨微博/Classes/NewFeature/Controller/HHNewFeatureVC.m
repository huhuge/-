//
//  HHNewFeatureVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/6.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#define NewFeatureCount 4

#import "HHNewFeatureVC.h"
#import "HHTabbarVC.h"


@interface HHNewFeatureVC ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HHNewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建一个scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < NewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width  = scrollW;
        imageView.height = scrollH;
        imageView.y      = 0;
        imageView.x      = i * scrollW;
        NSString *name   = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image  = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        //添加内容
        if (i == (NewFeatureCount - 1)) {
            [self setupLastImageView:imageView];
        }
        
    }

    scrollView.contentSize   = CGSizeMake(NewFeatureCount * scrollView.width, 0);
    scrollView.bounces       = NO;
    scrollView.delegate      = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIPageControl *pageControl  = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewFeatureCount;
    // 不用设置宽高也可以显示
    //    pageControl.width = 100;
    //    pageControl.height = 50;
    //    pageControl.userInteractionEnabled = NO;

    pageControl.centerX = scrollW / 2;
    pageControl.centerY = scrollH - 50;
    pageControl.currentPageIndicatorTintColor = HHRGBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = HHRGBColor(189, 189, 189);
//    pageControl.backgroundColor = [UIColor redColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x / scrollView.width;
    
    self.pageControl.currentPage = (int)(page + 0.5);
}

#pragma mark ------添加最后一个imageView的按钮------
- (void)setupLastImageView:(UIImageView *)imageView{
    
    imageView.userInteractionEnabled = YES;
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width/2;
    shareBtn.centerY = imageView.height * 0.65;
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];

    
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    [startBtn setTitle:@"开启微博" forState:UIControlStateNormal];
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];

    [imageView addSubview:startBtn];
}

#pragma mark ------分享------
- (void)shareClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

#pragma mark ------开始微博------
- (void)startClick{
    // 切换到主页
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[HHTabbarVC alloc] init];
    
}




@end
