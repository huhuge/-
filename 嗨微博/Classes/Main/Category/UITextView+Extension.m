//
//  UITextView+Extension.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)text {
    [self insertAttributedText:text settingBlock:nil];
}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *))settingBlock{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    [attributedText appendAttributedString:self.attributedText];
    
    
    // 插入图片表情
    NSUInteger loc = self.selectedRange.location;
    
//    [attributedText insertAttributedString:text atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    // 调用外面传进来的block
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    // 设置字体
    //    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    
    self.attributedText = attributedText;
    
    // 移动光标到表情后面
    self.selectedRange = NSMakeRange(loc + 1, 0);

}

@end
