//
//  HHDiscoverVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHDiscoverVC.h"
#import "HHSearchBar.h"

@interface HHDiscoverVC ()

@end

@implementation HHDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置左边放大镜
    HHSearchBar *searchBar = [HHSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    
    self.navigationItem.titleView = searchBar;

 }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



@end
