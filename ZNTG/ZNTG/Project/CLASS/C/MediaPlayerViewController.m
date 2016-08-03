//
//  MediaPlayerViewController.m
//  ZNTG
//
//  Created by FeiCao on 16/8/2.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Masonry.h"
#import "ZFPlayer.h"
#import "VideoInfoView.h"
#import "RelatedVideoCell.h"

@interface MediaPlayerViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation MediaPlayerViewController

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
    [self.playerView cancelAutoFadeOutControlBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    // 调用playerView的layoutSubviews方法
    if (self.playerView) { [self.playerView setNeedsLayout]; }
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser) {
        self.isPlaying = YES;
        [self.playerView pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self initializeDatas];
    [self setupPlayerView];
    [self initializeTabelView];
    [self initializeHeaderView];
}

- (void)initializeDatas {
    _cellHeight = (((self.view.width - (10 * 3)) / 2) * 9 / 16 + kScreenHeightScale(60));
    _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
}

- (void)initializeTabelView {
    CGRect tableViewFrame = CGRectMake(0, 20 + _playerView.height, self.view.width, (self.view.height - _playerView.height) - 20);
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)initializeHeaderView {
    VideoInfoView *headerView = [[VideoInfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kScreenHeightScale(334))];
//    headerView.backgroundColor = [UIColor purpleColor];
    _tableView.tableHeaderView = headerView;
}

- (void)setupPlayerView {
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(20);
    }];
    
    self.playerView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    
    self.playerView.videoURL = self.videoURL;
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    self.playerView.hasDownload = NO;
    
    // 如果想从xx秒开始播放视频
    // self.playerView.seekTime = 15;
    
    // 是否自动播放，默认不自动播放
    [self.playerView autoPlayTheVideo];
    __weak typeof(self) weakSelf = self;
    self.playerView.goBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(20);
            _tableView.hidden = NO;
        }];
        
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            _tableView.hidden = YES;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if (!_collectionView) {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, (_cellHeight + kScreenHeightScale(30)) * 3) collectionViewLayout:_collectionViewFlowLayout];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            _collectionView.bounces = NO;
            _collectionView.scrollEnabled = NO;
            _collectionView.showsVerticalScrollIndicator = NO;
            _collectionView.backgroundColor = kCustomColor(238, 238, 244, 1);
            [cell addSubview:_collectionView];
            [_collectionView registerNib:[UINib nibWithNibName:@"RelatedVideoCell" bundle:nil] forCellWithReuseIdentifier:@"RelatedVideoCell"];
            return cell;
        }
    }
    cell.textLabel.text = @"测试";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? (_cellHeight + kScreenHeightScale(30)) * 3 : kScreenHeightScale(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenHeightScale(80);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kScreenHeightScale(80))];
    headerView.backgroundColor = kCustomColor(238, 238, 244, 1);
    CGFloat markLabelHeight = kScreenHeightScale(32);
    CGFloat markLabelY = (headerView.height - markLabelHeight) / 2;
    UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  markLabelY, kScreenWidthScale(6), markLabelHeight)];
    markLabel.backgroundColor = kCustomColor(238, 36, 28, 1);
    [headerView addSubview:markLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(markLabel.right + kScreenWidthScale(20), markLabel.top, kScreenWidthScale(200), markLabel.height)];
    titleLabel.text = section == 0 ? @"相关视频" : @"评论";
    titleLabel.textColor = kCustomColor(22, 22, 22, 1);
    titleLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:titleLabel];
    return headerView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"RelatedVideoCell";
    RelatedVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.width - kScreenWidthScale(20) * 3) / 2, _cellHeight);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kScreenWidthScale(30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
