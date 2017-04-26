//
//  HHTextPart.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/25.
//  Copyright © 2017年 huhuge. All rights reserved.
// 文字的一部分

#import <Foundation/Foundation.h>

@interface HHTextPart : NSObject
/** 这段文字内容 */
@property (nonatomic, copy) NSString *text;
/** 这段文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 是否特殊文字 */
@property (nonatomic, assign, getter=isSpecial) BOOL special;
/** 是否为表情 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
