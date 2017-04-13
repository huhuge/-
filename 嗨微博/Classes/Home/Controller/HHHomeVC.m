//
//  HHHomeVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/4.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHHomeVC.h"
#import "HHSearchBar.h"
#import "HHDropdownMenu.h"
#import "HHTitleMenuVC.h"
#import "HHAccountTool.h"
#import "HHTitleButton.h"
#import "HHUser.h"
#import "HHStatus.h"
#import "MJExtension.h"
#import "HHStatusCell.h"
#import "HHLoadMoreFooter.h"
#import "HHStatusFrame.h"


@interface HHHomeVC ()<HHDropdownMenuDelegate,UIScrollViewDelegate>
/**
 *  微博数组（里面放的HHStatus模型，一个HHStatus对象代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation HHHomeVC

- (NSMutableArray *)statusFrames{
    if (!_statusFrames) {
        self.statusFrames = [[NSMutableArray alloc] init];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HHRGBColor(211, 211, 211);
//    self.tableView.contentInset = UIEdgeInsetsMake(HHStatusCellMargin, 0, 0, 0);
    
    [self setNavigation];
    
    [self setUserInfo];
    
    [self setupDownRefresh];
    
    [self setupUpRefresh];
    
    // 获得未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    
//    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    
    
}

#pragma mark ------显示未读数------
- (void)setupUnreadCount{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HHAccount *account = [HHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 微博的未读数
        //        int status = [responseObject[@"status"] intValue];
        // 设置提醒数字
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字(微博的未读数)
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:status.intValue];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HLog(@"请求失败-%@", error);
    }];

}


#pragma mark ------上拉加载------
- (void)setupUpRefresh{
    HHLoadMoreFooter *footer = [HHLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}


#pragma mark ------下拉刷新------
- (void)setupDownRefresh{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    [control beginRefreshing];
    [self loadNewStatus:control];
}


#pragma mark ------显示最新微博条数------
- (void)showNewStatusCount:(NSInteger)count{
    
    self.tabBarItem.badgeValue = nil;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.y = 64 - label.height;
    if (count == 0) {
        label.text = @"没有新的数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",(long)count];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

// 将HHStatus转成HHStatusFrame模型
- (NSArray *)statusFramesWithStatus:(NSArray *)statuses{
    
    NSMutableArray *frames = [NSMutableArray array];
    for (HHStatus *status in statuses) {
        HHStatusFrame *f = [[HHStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;

}


/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
- (void)loadNewStatus:(UIRefreshControl *)control
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSDictionary *responseObject = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeStatus" ofType:@"plist"]];
//        // 将 "微博字典"数组 转为 "微博模型"数组
//        NSArray *newStatuses = [HHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        // 将 HWStatus数组 转为 HWStatusFrame数组
//        NSArray *newFrames = [self statusFramesWithStatus:newStatuses];
//        
//        // 将最新的微博数据，添加到总数组的最前面
//        NSRange range = NSMakeRange(0, newFrames.count);
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrames insertObjects:newFrames atIndexes:set];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 结束刷新
//        [control endRefreshing];
//        
//        // 显示最新微博的数量
//        [self showNewStatusCount:newStatuses.count];
//    });
//    
//    return;
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:mgr.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    mgr.responseSerializer.acceptableContentTypes = contentTypes;
    
    // 2.拼接请求参数
    HHAccount *account = [HHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    HHStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HLog(@"%@",responseObject);
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [HHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatus:newStatuses];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        // 刷新表格
        
        // 结束刷新
        [control endRefreshing];
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
        
        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HLog(@"请求失败-%@", error);
        
        // 结束刷新刷新
        [control endRefreshing];
    }];
}



/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HHAccount *account = [HHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    HHStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [HHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatus:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}


#pragma mark ------获取用户昵称------
- (void)setUserInfo{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:mgr.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    mgr.responseSerializer.acceptableContentTypes = contentTypes;

    HHAccount *account = [HHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HHUser *user = [HHUser objectWithKeyValues:responseObject];
        
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:user.name forState:UIControlStateNormal];

        // 存储昵称
        account.name = user.name;
        [HHAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];

}

#pragma mark ------设置导航栏------
- (void)setNavigation{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //中间标题按钮
    HHTitleButton *titleBtn = [HHTitleButton buttonWithType:UIButtonTypeCustom];
    NSString *name = [HHAccountTool account].name;
    
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
//    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HHStatusCell *cell = [HHStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HHStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}


#pragma mark ------friendsearch------
- (void)friendSearch{
    NSLog(@"friendsearch");
}

#pragma mark ------pop------
- (void)pop{
    NSLog(@"pop");

}

#pragma mark ------点击标题------
- (void)titleClick:(UIButton *)sender{
    
    //创建下来菜单
    HHDropdownMenu *menu = [HHDropdownMenu menu];
    
    //设置内容
    HHTitleMenuVC *menuVC = [[HHTitleMenuVC alloc] init];
    menuVC.view.height = 200;
    menuVC.view.width = 200;
    menu.delegate = self;
    menu.contentController = menuVC;
    
    //显示
    [menu showFrom:sender];
    
    
    
}

#pragma mark ------dropdownMenu delegata------
//菜单显示
- (void)dropdownMenuDidDismissed:(HHDropdownMenu *)menu{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = NO;
}

//菜单销毁
- (void)dropdownMenuDidShow:(HHDropdownMenu *)menu{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }

}




@end
