//
//  HHTitleMenuVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/5.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHTitleMenuVC.h"

@interface HHTitleMenuVC ()

@end

@implementation HHTitleMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试菜单---%ld",indexPath.row];
    return cell;

}


@end
