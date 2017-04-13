//
//  HHStatusCell.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/9.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHStatusFrame;

@interface HHStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) HHStatusFrame *statusFrame;

@end
