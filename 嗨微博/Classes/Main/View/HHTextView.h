//
//  HHTextView.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/13.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;


@end
