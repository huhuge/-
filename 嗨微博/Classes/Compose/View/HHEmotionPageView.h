//
//  HHEmotionPageView.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
// 用来表示一页表情（1~20个）

// 一行最多7列
#define HHEmotionMaxCols 7
// 一页最多3行
#define HHEmotionMaxRows 3
// 每一页的表情个数
#define HHEmotionPageSize ((HHEmotionMaxCols * HHEmotionMaxRows) - 1)


#import <UIKit/UIKit.h>



@interface HHEmotionPageView : UIView

/** 这一页显示的表情 */
@property (nonatomic, strong) NSArray *emotions;
@end
