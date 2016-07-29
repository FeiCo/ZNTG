//
//  HomeViewController.m
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "TermSheetViewController.h"
#import "PlateView.h"
#import "HomeCell.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray *cycleImages;
@property (nonatomic, strong) NSArray *dataLists;
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
    _dataLists = @[ @{
                        @"name" : @"何燕华",
                        @"contents" : @[@"对方教室里吉德津科了附近的昆仑山积分多少。",
                                       @"距离放假都是反对撒积分多少了解啊发的是非得失封疆大吏沙发加电视。",
                                       @"的风急浪高激发了大家根深蒂固家理发店，输个干净费拉达斯结果发了快递高峰的歌",
                                       @"了解过了附近的水果放到零售价格；了附近的赶快来减肥的水果放了的"
                                       ],
                        @"buyAmount" : @"1428",
                        @"price" : @"188"
                        },
                    
                    @{
                        @"name" : @"屈长江",
                        @"contents" : @[@"赶紧来惹今晚感染了我津科了附近的昆仑山积分多少。",
                                        @"哦额品味 i 条绒蛾今晚同 i 任何问题和肉鹅今晚同 i 让饥饿我IP特价日哦额外警惕哦让饥饿我体检肉IE我警惕哦热降温。",
                                        @"婆婆开通热恐怕我看透热舞可突破认可哦天空热捧",
                                        @"全家人科列维奇加热拉沃奇金热就为了空气加热看我前几天看见饿哭了我就去听了叫我起来看加特林矿务局其他旅客将讨论委屈的"
                                        ],
                        @"buyAmount" : @"399",
                        @"price" : @"289"
                        },
                    @{
                        @"name" : @"权卫",
                        @"contents" : @[@"酷狗烹饪课哦抛开光荣朋克工棚快给我苹果看破万矿工热裤公平热裤更热。",
                                        @"热舞前几天看了让我去季塔连科让我去；我前几天绕口令期望；今天看了让我去。",
                                        @"一热哦我抛弃任何无 i 去回归我去哦和UI我去慧如诶我哦",
                                        @"请问而且尔问题全额问题请问特委屈特委屈特委屈特委屈特委屈"
                                        ],
                        @"buyAmount" : @"13849",
                        @"price" : @"99"
                        }
                   ];
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
    return _dataLists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dataDict = [_dataLists objectAtIndex:indexPath.section];
    [cell handleHomeCellWithName:[dataDict objectForKey:@"name"]
                       buyAmount:[dataDict objectForKey:@"buyAmount"]
                           price:[dataDict objectForKey:@"price"]
                        contents:[dataDict objectForKey:@"contents"]];
    
    cell.contentLabel.text = [[dataDict objectForKey:@"contents"] objectAtIndex:indexPath.section];
    [cell.buyButton addTarget:self action:@selector(buyNowButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Action Methods

- (void)buyNowButton:(UIButton *)sender {
    TermSheetViewController *termSheetViewController = [[TermSheetViewController alloc] init];
    [self.navigationController pushViewController:termSheetViewController animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenHeightScale(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"循环广告被点击...!");
}


@end
