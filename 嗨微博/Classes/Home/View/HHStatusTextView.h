//
//  HHStatusTextView.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/25.
//  Copyright © 2017年 huhuge. All rights reserved.
// 显示微博正文textView


#import <UIKit/UIKit.h>

@interface HHStatusTextView : UITextView
/** 所有的特殊字符串（里面存放着HHSpecial） */
@property (nonatomic, strong) NSArray *specials;

@end
