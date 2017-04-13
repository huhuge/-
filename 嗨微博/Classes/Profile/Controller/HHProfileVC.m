//
//  HHProfileVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHProfileVC.h"
#import "HHTest1VC.h"

@interface HHProfileVC ()

@end

@implementation HHProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self action:@selector(setting)];

}

- (void)setting {
    HHTest1VC *nextVC = [[HHTest1VC alloc] init];
    nextVC.title = @"text1";
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



@end
