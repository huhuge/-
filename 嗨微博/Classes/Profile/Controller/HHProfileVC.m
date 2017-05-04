//
//  HHProfileVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHProfileVC.h"
#import "HHTest1VC.h"
#import "SDWebImageManager.h"

@interface HHProfileVC ()

@end

@implementation HHProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 字节大小
    NSUInteger byteSize = [SDImageCache sharedImageCache].getSize;
    double size = byteSize / 1000 / 1000;
    self.navigationItem.title = [NSString stringWithFormat:@"缓存大小（%.1fM）",size];
    
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:0 target:self action:@selector(clearCache)];

}

- (void)setting {
    HHTest1VC *nextVC = [[HHTest1VC alloc] init];
    nextVC.title = @"text1";
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

#pragma mark ------清除缓存------
- (void)clearCache{
    UIActivityIndicatorView *circle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [circle startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:circle];
    
    //清除
    [[SDImageCache sharedImageCache] clearDisk];
    
    // 显示按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:0 target:self action:@selector(clearCache)];
    self.navigationItem.title = [NSString stringWithFormat:@"缓存大小（0M）"];

}


#pragma mark ------文件管理------
- (void)fileOperation{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 获取cache缓存路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 清除缓存
    [mgr removeItemAtPath:caches error:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



@end
