//
//  HHComposeToolbar.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/13.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HHComposeToolbarButtonTypeCamera,   // 拍照
    HHComposeToolbarButtonTypePicture,  // 图片
    HHComposeToolbarButtonTypeMention,  // @
    HHComposeToolbarButtonTypeTrend,    // #话题
    HHComposeToolbarButtonTypeEmotion,  // 表情
} HHComposeToolbarButtonType;

@class HHComposeToolbar;

@protocol HHComposeToolbarDelegate <NSObject>

@optional

- (void)composeToolbar:(HHComposeToolbar *)toolbar DidClcikButton:(HHComposeToolbarButtonType)buttonType;

@end

@interface HHComposeToolbar : UIView
@property (nonatomic, weak) id<HHComposeToolbarDelegate> delegate;

/** 是否显示表情按钮 */
@property (nonatomic, assign) BOOL showKeyboardButton;

@end
