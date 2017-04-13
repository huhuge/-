//
//  NSString+Extension.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/11.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)stringSizeWithFont:(UIFont *)font;

@end
