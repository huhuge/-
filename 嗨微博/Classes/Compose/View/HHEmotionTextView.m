//
//  HHEmotionTextView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/19.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHEmotionTextView.h"
#import "HHEmotion.h"
#import "HHEmotionAttachment.h"

@implementation HHEmotionTextView

- (void)insertEmotion:(HHEmotion *)emotion{
    if (emotion.code) {
        //insertText: 将文字插入到光标所在位置
        
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        
        // 加载图片
        HHEmotionAttachment *attch = [[HHEmotionAttachment alloc] init];
        attch.emotion = emotion;
        
        // 设置图片尺寸
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);

        // 创建属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
      
        
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
        
    }

}

- (NSString *)fullText{
    NSMutableString *fullText = [NSMutableString string];
    
    // 遍历所有的属性文字
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {

        // 如果是图片表情
        HHEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {
            [fullText appendString:attch.emotion.chs];
        } else { // emoji、普通文本
            
            // 获得该范围的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];

        }
        
    }];
    
    return fullText;
}


@end
