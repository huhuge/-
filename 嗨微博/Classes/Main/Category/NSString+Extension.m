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

- (NSInteger)fileSize{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    if (exists == 0) return 0; // 文件（夹）不存在
    if (dir) { // self是一个文件夹
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subPath in subpaths) {
            NSString *fullSubPath = [self stringByAppendingPathComponent:subPath];
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (dir == NO) {
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubPath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self 是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil] [NSFileSize] integerValue];
    }
    
    
}

@end
