//
//  HHSpecial.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/25.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHSpecial : NSObject
/** 这段特殊文字内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 这段特殊文字的矩形框（存放CGrect） */
@property (nonatomic, strong) NSArray *rects;

@end
