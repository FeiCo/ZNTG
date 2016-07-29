//
//  HomeViewController.m
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "PlateView.h"
#import "HomeCell.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray *cycleImages;
@end

@implementation HomeViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDatas];
    [self initializeNavigation];
    [self initializeTableView];
    [self initializeCycleScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeDatas {
    _cycleImages = @[ @"banner", @"banner", @"banner" ];
}

- (void)initializeNavigation {
    self.title = @"首页";
}

- (void)initializeTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self registerNib];
}

- (void)registerNib {
    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
}

- (void)initializeCycleScrollView {
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kScreenHeightScale(236) + kScreenHeightScale(20) + kScreenHeightScale(270))];
    
    // 循环新闻
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kScreenHeightScale(236)) imageURLStringsGroup:_cycleImages];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"banner"];
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.autoScrollTimeInterval = 5;
    [tableHeaderView addSubview:_cycleScrollView];
    
    // 股市行情
    UIView *marketView = [[UIView alloc] initWithFrame:CGRectMake(0, _cycleScrollView.bottom + kScreenHeightScale(20), CGRectGetWidth(self.view.frame), kScreenHeightScale(270))];
    marketView.backgroundColor = [UIColor whiteColor];
    [tableHeaderView addSubview:marketView];
    
    _tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenHeightScale(520);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenHeightScale(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kScreenHeightScale(200))];
//    
//    // -----
//    PlateView *plateView = [[PlateView alloc] initWithFrame:CGRectMake(0, kScreenHeightScale(20), CGRectGetWidth(self.view.frame), kScreenHeightScale(200) - kScreenHeightScale(20))];
//    plateView.backgroundColor = [UIColor whiteColor];
//    [headerView addSubview:plateView];
//    return headerView;
//}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"循环广告被点击...!");
}


@end
