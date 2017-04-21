//
//  HHEmotion.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/15.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHEmotion : NSObject<NSCoding>

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji的16进制编码 */
@property (nonatomic, copy) NSString *code;

@end
