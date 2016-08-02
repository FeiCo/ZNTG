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

@interface MediaPlayerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
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
    [self initializeTabelView];
    [self setupPlayerView];
}

- (void)initializeTabelView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)setupPlayerView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kScreenHeightScale(510))];
    _tableView.tableHeaderView = headerView;
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topView];
    [topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(20);
    }];
    
    self.playerView = [[ZFPlayerView alloc] init];
    [headerView addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    
    self.playerView.placeholderImageName = @"loading_bgView1";
    self.playerView.videoURL = self.videoURL;
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    self.playerView.hasDownload = YES;
    
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
        }];
        
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"测试";
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenHeightScale(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenHeightScale(110);
}

@end
