
//
//  HHStatusTextView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/25.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHStatusTextView.h"
#import "HHSpecial.h"

#define HHStatusTextViewCoverTag 999

@implementation HHStatusTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.editable = NO;
        self.scrollEnabled = NO;
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    if (action == @selector(copy:))
    {
        return NO;
    }
    
    return NO;
}

- (void)setupSpecialRects{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (HHSpecial *special in specials) {
        self.selectedRange = special.range;
        
        // 获得选中范围的矩形框
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        
        for (UITextSelectionRect *selectRect in selectionRects) {
            CGRect rect = selectRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            
            // 添加rect
            [rects addObject:[NSValue valueWithCGRect:rect]];
            
        }
        special.rects = rects;
    }
    
}

// 找出被触摸的特殊字符串
- (HHSpecial *)touchingSpecialWithPoint:(CGPoint)point{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    for (HHSpecial *special in specials) {
        
        for (NSValue *rectValue in special.rects) {
            
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) { // 点中了特殊字符串
                return special;
            }
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    // 根据触摸点获得特殊字符
    HHSpecial *special = [self touchingSpecialWithPoint:point];
    
    // 初始化矩形框
    [self setupSpecialRects];
    
    // 在被点特殊字符串后面显示高亮背景
    for (NSValue *rectValue in special.rects) {
        
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = HHRGBColor(179, 193, 211);
        cover.tag = HHStatusTextViewCoverTag;
        cover.frame = rectValue.CGRectValue;
        cover.layer.cornerRadius = 4;
        [self insertSubview:cover atIndex:0];
        HLog(@"--- %@ ---",special.text); // 这里可以拿到特殊字符进行操作（如跳网页）
    }

    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *child in self.subviews) {
        if (child.tag == HHStatusTextViewCoverTag) {
            [child removeFromSuperview];
        }
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    return [super hitTest:point withEvent:event];
//}

// 告诉系统触摸点point是否在这个UI控件身上
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    // 初始化矩形框
    [self setupSpecialRects];

    // 根据触摸点获得特殊字符
    HHSpecial *special = [self touchingSpecialWithPoint:point];

    return special;
}

// 判断点在谁身上 : 调用 - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
// 由触摸点所在的UI控件选出处理事件的UI控件 : - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
@end
