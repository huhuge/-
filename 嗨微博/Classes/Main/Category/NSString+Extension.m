//
//  NSString+Extension.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/11.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize  maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}
- (CGSize)stringSizeWithFont:(UIFont *)font{
    return [self stringSizeWithFont:font maxWidth:MAXFLOAT];
}


@end
