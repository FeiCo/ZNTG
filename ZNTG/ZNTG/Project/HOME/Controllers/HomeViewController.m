//
//  HomeViewController.m
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#import "HomeViewController.h"
#import "TermSheetViewController.h"
#import "SDCycleScrollView.h"
#import "PlateView.h"
#import "HomeCell.h"
#import "MarketView.h"
#import "TeacherModels.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) PlateView *plateView;
@property (nonatomic, strong) NSArray *cycleImages;
@property (nonatomic, strong) NSArray *marketDatas;
@property (nonatomic, strong) NSArray *victoryWinList; // 胜赢
@property (nonatomic, strong) NSArray *brightWinList; // 智赢
@property (nonatomic, strong) NSArray *wiseWinList;  // 慧赢
@property (nonatomic, strong) NSArray *topWinList;  // 私人订制
@property (nonatomic, strong) NSArray *maxArray; // 大哥
@property (nonatomic, assign) NSInteger index;
@end

@implementation HomeViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDatas];
    [self initializeNavigation];
    [self initializeTableView];
    [self initializeCycleScrollView];
    [self requestsTeacher];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeDatas {
    _index = 0;
    _cycleImages = @[ @"banner", @"banner", @"banner" ];
    _marketDatas = @[
                     @{
                         @"name" : @"上证指数",
                         @"price" : @"2913.26",
                         @"change" : @"-84.51",
                         @"applies" : @"-2.02%"
                         },
                     @{
                         @"name" : @"深证指数",
                         @"price" : @"10200.54",
                         @"change" : @"-372.48",
                         @"applies" : @"-3.81%"
                         },
                     @{
                         @"name" : @"沪深指数",
                         @"price" : @"2139.19",
                         @"change" : @"-84.29",
                         @"applies" : @"-2.82%"
                         },
                     @{
                         @"name" : @"上海指数",
                         @"price" : @"5439.32",
                         @"change" : @"-44.19",
                         @"applies" : @"-5.72%"
                         },
                     @{
                         @"name" : @"深圳指数",
                         @"price" : @"262.23",
                         @"change" : @"-52.82",
                         @"applies" : @"-1.42%"
                         },
                     
                     ];
}

- (void)initializeNavigation {
    self.title = @"首页";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)initializeTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - kNavigationBarHeight - kStateBarHeight - kTabBarHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self registerNib];
}

- (void)registerNib {
    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeCell"];
}

- (void)initializeCycleScrollView {
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kScreenHeightScale(236) + kScreenHeightScale(20) + kScreenHeightScale(230))];
    tableHeaderView.backgroundColor = kCustomColor(239, 239, 244, 1);
    
    // 循环新闻
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kScreenHeightScale(236)) imageURLStringsGroup:_cycleImages];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"banner"];
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.autoScrollTimeInterval = 5;
    [tableHeaderView addSubview:_cycleScrollView];
    
    // 背景色
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _cycleScrollView.bottom + kScreenHeightScale(20), self.view.width, kScreenHeightScale(230))];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.5)];
    topLine.backgroundColor = kCustomColor(200, 200, 200, 1);
    [bgView addSubview:topLine];
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeightScale(230) - 0.5, self.view.width, 0.5)];
    bottomLine.backgroundColor = kCustomColor(200, 200, 200, 1);
    [bgView addSubview:bottomLine];
    [tableHeaderView addSubview:bgView];
    
    // 股市行情
    CGFloat marketViewWidth = CGRectGetWidth(self.view.frame) / 3;
    NSInteger marketCount = _marketDatas.count;
    UIScrollView *marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _cycleScrollView.bottom + kScreenHeightScale(20), self.view.width, kScreenHeightScale(140))];
    marketScrollView.contentSize = CGSizeMake(marketViewWidth * marketCount, kScreenHeightScale(140));
    marketScrollView.scrollEnabled = YES;
    marketScrollView.showsHorizontalScrollIndicator = NO;
    marketScrollView.showsVerticalScrollIndicator = NO;
    MarketView *marketView;
    for (int i = 0; i < marketCount; i++) {
        marketView = [[MarketView alloc] initWithFrame:CGRectMake(i * marketViewWidth, 0, marketViewWidth, kScreenHeightScale(140))];
        NSDictionary *dict = [_marketDatas objectAtIndex:i];
        [marketView handleMarketViewWithName:[dict objectForKey:@"name"]
                                     atPrice:[dict objectForKey:@"price"]
                                    atChange:[dict objectForKey:@"change"]
                                   atApplies:[dict objectForKey:@"applies"]];
        
        [marketScrollView addSubview:marketView];
    }
    [tableHeaderView addSubview:marketScrollView];

    // 股市行情logo
    
    UIImage *markImage = [UIImage imageNamed:@"gushi"];
//    CGFloat marketImageWidth = markImage.size.width;
    CGFloat marketImageHeight = markImage.size.height;
    UIImageView *marketImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidthScale(24), marketScrollView.bottom, self.view.width - kScreenWidthScale(24) * 2, marketImageHeight)];
    marketImage.image = [UIImage imageNamed:@"gushi"];
    [tableHeaderView addSubview:marketImage];
    
    _tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - Action Methods

- (void)buyNowButton:(UIButton *)sender {
    TermSheetViewController *termSheetViewController = [[TermSheetViewController alloc] init];
    [self.navigationController pushViewController:termSheetViewController animated:YES];
}

- (void)seeaboutTeacherDescription:(UIButton *)sender {
    TeacherModels *teacherModels = [_maxArray[_index] objectAtIndex:sender.tag - 100];
    teacherModels.isSelected = !teacherModels.isSelected;
    
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *selectedIndexPath = [_tableView indexPathForCell:cell];
    
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:selectedIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _victoryWinList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HomeCell";
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TeacherModels *teacherModels = [_maxArray[_index] objectAtIndex:indexPath.row];
    
    [cell handleHomeCellWithPhotoURL:[NSURL URLWithString:teacherModels.photoLocation]
                                name:teacherModels.teacherName
                               price:teacherModels.roomPrice
                              buyNum:teacherModels.userNumber
                         mobilePhone:teacherModels.mobilePhone
                        currentIndex:_index
                         description:teacherModels.descriptions
                          isSelected:teacherModels.isSelected];
    
    cell.seeaboutButton.tag = 100 + indexPath.row;
    [cell.seeaboutButton addTarget:self
                            action:@selector(seeaboutTeacherDescription:)
                  forControlEvents:UIControlEventTouchUpInside];
        
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherModels *teacherModels = [_maxArray[_index] objectAtIndex:indexPath.row];
    if (teacherModels.isSelected == YES) {
        return kScreenHeightScale(184) + teacherModels.cellHeight + kScreenHeightScale(20) + kScreenHeightScale(20);
    }
     return kScreenHeightScale(184);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenHeightScale(230);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    if (!_plateView) {
        _plateView = [[PlateView alloc] init];
        _plateView.frame = CGRectMake(0, kScreenHeightScale(20), self.view.width, kScreenHeightScale(180));
        _plateView.backgroundColor = [UIColor whiteColor];
        [_plateView plateViewBlock:^(UIButton *sender) {
            _index = sender.tag;
            for (int i=0; i<_wiseWinList.count; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }
    [headerView addSubview:_plateView];
    
    return headerView;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"循环广告被点击...!");
}

#pragma mark - Network Requests

- (void)requestsTeacher {
    NSString *urlString = @"http://192.168.0.135:8080/ws/rest/teacher/getIndexHome/*/*/*";
    [MSNetRequest requestMethodsWithPOST:nil url:urlString successBlock:^(id responseObject) {
        
        NSDictionary *jsonDictionary = [responseObject jsonValueDecoded];
        NSDictionary *resultData = [jsonDictionary objectForKey:@"resultData"];
        
        NSArray *brightWinLit = [resultData objectForKey:@"brightWinLit"];
        NSArray *topWinLit = [resultData objectForKey:@"topWinLit"];
        NSArray *victoryWinLit = [resultData objectForKey:@"victoryWinLit"];
        NSArray *wiseWinLit = [resultData objectForKey:@"wiseWinLit"];
        
        NSMutableArray *tempArray01 = [NSMutableArray arrayWithCapacity:brightWinLit.count];
        NSMutableArray *tempArray02 = [NSMutableArray arrayWithCapacity:topWinLit.count];
        NSMutableArray *tempArray03 = [NSMutableArray arrayWithCapacity:victoryWinLit.count];
        NSMutableArray *tempArray04 = [NSMutableArray arrayWithCapacity:wiseWinLit.count];
        
        for (NSDictionary *dict in brightWinLit) {
            [tempArray01 addObject:[TeacherModels teacherModelsFromDictionary:dict]];
        }
        for (NSDictionary *dict in topWinLit) {
            [tempArray02 addObject:[TeacherModels teacherModelsFromDictionary:dict]];
        }
        for (NSDictionary *dict in victoryWinLit) {
            [tempArray03 addObject:[TeacherModels teacherModelsFromDictionary:dict]];
        }
        for (NSDictionary *dict in wiseWinLit) {
            [tempArray04 addObject:[TeacherModels teacherModelsFromDictionary:dict]];
        }
        _brightWinList  = [NSArray arrayWithArray:tempArray01];
        _topWinList     = [NSArray arrayWithArray:tempArray02];
        _victoryWinList = [NSArray arrayWithArray:tempArray03];
        _wiseWinList    = [NSArray arrayWithArray:tempArray04];
        
        _maxArray = [NSArray arrayWithObjects:_brightWinList,_topWinList,_victoryWinList,_wiseWinList, nil];
        [_tableView reloadData];
        
    } failureBlock:^(NSString *err) {
        NSLog(@"err:%@",err);
    }];
}
@end
