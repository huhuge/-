//
//  HHStatusToolbar.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/11.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHStatus;

@interface HHStatusToolbar : UIView

+ (instancetype)toolbar;

@property (nonatomic, strong) HHStatus *status;

@end
