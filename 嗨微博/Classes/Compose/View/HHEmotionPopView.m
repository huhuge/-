//
//  HHEmotionPopView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHEmotionPopView.h"
#import "HHEmotion.h"
#import "HHEmotionButton.h"

@interface HHEmotionPopView()
@property (weak, nonatomic) IBOutlet HHEmotionButton *emotionButoon;

@end

@implementation HHEmotionPopView

+ (instancetype)popView{
    return [[[NSBundle mainBundle] loadNibNamed:@"HHEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(HHEmotionButton *)button{
    
    if (button == nil) return;
    // 给popView传值
    self.emotionButoon.emotion = button.emotion;
    
    // 取得最上面窗口
    UIWindow *window =[UIApplication sharedApplication].windows.lastObject;
    [window addSubview:self];
    
    // 计算出被点击按钮在Window中的frame
    CGRect senderF = [button convertRect:button.bounds toView:nil];
    
    self.y = CGRectGetMidY(senderF) - self.height;
    self.centerX = CGRectGetMidX(senderF);

}




@end
