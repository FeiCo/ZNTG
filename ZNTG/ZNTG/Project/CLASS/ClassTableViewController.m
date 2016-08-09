//
//  ClassTableViewController.m
//  ZNTG客户端
//
//  Created by Peter on 5/30/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "ClassTableViewController.h"
#import "ClassCubeTableViewCell.h"
#import "MediaPlayerViewController.h"

#import "CustomAlertView.h"
#import "LYHTTPClient.h"

#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]

@interface ClassTableViewController ()<ClassCubeImageClickdelegate>


@property (strong, nonatomic) NSMutableArray *data;
@property(nonatomic,strong) NSArray * dataarray;


//ME ADD
@property (nonatomic,strong) NSMutableArray *xxdataarray;
@property (nonatomic,strong) NSMutableArray *hqjdArray;
@property (nonatomic,strong) NSMutableArray *jchgArray;


@property(nonatomic,assign) NSInteger pagecount;


@end

@implementation ClassTableViewController


//ME ADD

//网络请求
-(void)netWorkAsking {
    NSString *url1 = @"http://192.168.0.135:8080/ws/rest/teacher/getCourseList/*/*";
    
    [LYHTTPClient POST:url1 parameters:nil cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    [LYHTTPClient POST:url1 parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"NETWORKAKING  1");
        NSDictionary *tempt = [NSDictionary new];
        tempt = responseObject;
        NSArray *netWorkAsking1 = [NSArray new];
        _xxdataarray = [NSMutableArray array];
        @try
        {
            netWorkAsking1 = [tempt valueForKey:@"resultData"];
            for (NSDictionary *dict in netWorkAsking1) {
                [_xxdataarray addObject:dict];
            }
            
        }@catch (NSException * e) {
            
            NSLog(@"xxxx%@",e._IQDescription);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"FAIL TO LOAD DATA");
    }];
    
}





-(NSDictionary *)dictWithResponseArray:(NSArray *)array andType:(NSString *) str{
    NSDictionary *dict = [NSDictionary new];
    for(NSDictionary *DIC in array) {
        if([[DIC valueForKey:@"type"]  isEqual: str])
        {
            dict = DIC;
            
        }
    }
    return dict;
}




-(NSMutableArray *)arrayPharseFromDictionary:(NSDictionary *) dict type:(NSString *)type {
    NSMutableArray *temptarray = [NSMutableArray new];
    temptarray = [dict valueForKey:@"retData"];
    
    return temptarray;
}




-(void)loadingMoreData {
    
    NSString *url1 = @"http://tv1.bdcgw.cn/m/index.php/Home/Getdata/Video_view";
    
//    NSString *asktype;
//    if (_isHQJD == 1) {
//        asktype = @"52";
//    }
//    else
//    {
//        asktype = @"53";
//    }
//    
//    
//    NSString *pagenumber = [NSString stringWithFormat:@"%li",(long)_pagecount + 1];
//    NSLog(@"pagenumbervalueis%li",_pagecount);
//    
//    NSDictionary *parameters = [NSDictionary new];
//    parameters = @{@"page":pagenumber,@"id":asktype};
//    [LYHTTPClient POST:url1 parameters:parameters cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSArray *tempt = [NSArray new];
//        
//        if ([responseObject respondsToSelector:@selector(floatValue)] == 0) {
//            
//            _pagecount++;
//            
//            tempt = [responseObject valueForKey:@"retData"];
//            NSMutableArray *tempt1 = [[NSMutableArray alloc] init];
////            tempt = _isHQJD == YES ? [_hqjdArray copy ] : [_jchgArray copy];
//
//            if(_isHQJD == YES) {
//                
//                for (NSDictionary *dict in _hqjdArray) {
//                    [tempt1 addObject:dict];
//                }
//                for (NSDictionary * dict in tempt) {
//
//                        [tempt1 addObject:dict];
//                }
//                
//                _hqjdArray = tempt1;
//            }
//            else
//            {
//                
//                for (NSDictionary *dict in _jchgArray) {
//                    [tempt1 addObject:dict];
//                }
//                for (NSDictionary * dict in tempt) {
//                    
//                    [tempt1 addObject:dict];
//                }
//                
//                _jchgArray = tempt1;
//
//            }
//            
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
//            [self.tableView.mj_footer endRefreshing];
//        }
//        else
//        {
//        [self.tableView.mj_footer endRefreshing];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [self.tableView.mj_footer endRefreshing];
//    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _pagecount = 0;
    [self netWorkAsking];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.title = @"课件";
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 10)];
    [self setHeaderRefresh];
    [self setFooterRefresh];
//    self.tableView.backgroundColor = color(245, 245, 245, 1);
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 10)];
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    self.refreshControl= control;
//    self.tableView.tableFooterView = headerView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - data setting

-(NSArray *)dataarray {
    
    NSMutableArray *totalarray = [NSMutableArray array];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"tuijanZBKC.plist" ofType:nil];
    NSArray *dictArray2 = [NSArray arrayWithContentsOfFile:path2];

    [totalarray addObject:dictArray2];
    _dataarray = totalarray;
    return _dataarray;
}


-(NSMutableArray *)xxdataarray {
    if (!_xxdataarray) {
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"tempt.plist" ofType:nil];
    NSMutableArray *dictArray2 = [NSMutableArray arrayWithContentsOfFile:path2];
    

    _xxdataarray = dictArray2;
    }
    return _xxdataarray;
}




-(void)setHeaderRefresh {
    
//    __unsafe_unretained __typeof(self) weakSelf = self;
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadNewData];
//    }];
//    
//    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];

    
}




- (void)setFooterRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
//    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
}


#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    [self netWorkAsking];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    [self loadingMoreData];
}



- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:@""];
        }
    }
    return _data;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

return (_xxdataarray.count - 1) / 2 + 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassCubeTableViewCell *cell = [ClassCubeTableViewCell ClassCubeWithTableView:tableView];
    int row = (int)indexPath.row;
    cell.delegate = self;
  
    
    if((2 * row + 1) == _xxdataarray.count)
    {
        
        cell.dataarrayLeft = _xxdataarray[2 * row];
        cell.dataarrayRight = nil;
        //            cell.dataarrayRight = zhiweidic;
    }
    else
    {
        cell.dataarrayLeft = self.xxdataarray[2 * row];
        cell.dataarrayRight = self.xxdataarray[2 * row + 1];
    }

    cell.contentView.backgroundColor = color(245, 245, 245, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)clickButtonArray:(NSArray *)array {
    
    NSLog(@"click event pass title is%@",array);
    
        UIView *contentv= [[UIView alloc] init];
        contentv.backgroundColor =[UIColor redColor];
        UIView *contentv1= [[UIView alloc] init];
        contentv1.backgroundColor =[UIColor blueColor];
    
        [CustomAlertView popViewWithTitle:@"xxxx" contentText:contentv contentFrame:CGRectMake(20, 20, 40, 200) bottomView:contentv1 bottomFrame:CGRectMake(20, 20, 40, 0) leftButtonTitle:@"试看" rightButtonTitle:@"购买" leftBlock:^{
            NSLog(@"试看");
            MediaPlayerViewController *mediaPlayer = [MediaPlayerViewController new];
            mediaPlayer.hidesBottomBarWhenPushed = YES;
            NSURL *usl = [NSURL URLWithString:[array valueForKey:@"previewAddress"]];
            mediaPlayer.videoURL = usl;
            [self.navigationController pushViewController:mediaPlayer animated:YES];
        } rightBlock:^{
            NSLog(@"购买");
        } dismissBlock:^{
           NSLog(@"取消");
        }];
    
//    YYReachability * rechability = [YYReachability reachability];
//    bool iswifi = (rechability.status == YYReachabilityStatusWiFi);
//    
//    if (iswifi) {
//        
//        VVViewNoControlPlayerViewController *shipin = [[VVViewNoControlPlayerViewController alloc] initWithUrl:[array valueForKey:@"url"] VideoType:1 LocalVideoTitle:nil IsLive:NO];
//        //    [shipin setValue:[array valueForKey:@"title"] forKey:[array valueForKey:@"abstract"]];
//        [shipin setTitle:[array valueForKey:@"title"] andAbstract:[array valueForKey:@"abstract"]];
//        shipin.isHQJD = _isHQJD;
//        shipin.hidesBottomBarWhenPushed = YES;
//        [self presentViewController:shipin animated:YES completion:nil];
//    }
//    else {
//        
//        
//        __weak __typeof(&*self)weakSelf = self;
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您当前未在wifi网络，确定播放视频" preferredStyle:UIAlertControllerStyleAlert];
//        
//        // Create the actions.
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//            
//        }];
//        
//        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            
//            VVViewNoControlPlayerViewController *shipin = [[VVViewNoControlPlayerViewController alloc] initWithUrl:[array valueForKey:@"url"] VideoType:1 LocalVideoTitle:nil IsLive:NO];
//            //    [shipin setValue:[array valueForKey:@"title"] forKey:[array valueForKey:@"abstract"]];
//            [shipin setTitle:[array valueForKey:@"title"] andAbstract:[array valueForKey:@"abstract"]];
//            shipin.isHQJD = _isHQJD;
//            shipin.hidesBottomBarWhenPushed = YES;
//            [weakSelf presentViewController:shipin animated:YES completion:nil];
//        }];
//        
//        // Add the actions.
//        [alertController addAction:cancelAction];
//        [alertController addAction:otherAction];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
//        // contains key
//    }
}


//#pragma mark - show 提示信息
//
//- (void)showMessage:(NSString *)msg {
//    CGFloat padding = 10;
//    
//    UILabel *label = [UILabel new];
//    label.text = msg;
//    label.font = [UIFont systemFontOfSize:16];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
//    label.width = self.view.width;
//    
//    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
//    
//    label.bottom = 0;
//    [self.view addSubview:label];
//    [UIView animateWithDuration:0.3 animations:^{
//        label.top =  0;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            label.bottom =  0;
//        } completion:^(BOOL finished) {
//            [label removeFromSuperview];
//        }];
//    }];
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 关闭屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}
@end
