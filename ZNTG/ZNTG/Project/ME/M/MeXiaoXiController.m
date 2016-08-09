//
//  MeXiaoXiController.m
//  testtest
//
//  Created by Peter on 7/29/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "MeXiaoXiController.h"


#import "xiaoxiXQTableViewCell.h"
#import "xiaoxiXQ.h"
#import "xiaoxiXQdata.h"


#import "XiaoXiHuiFuCell.h"
#import "XiaoXiHuiFu.h"
#import "XiaoXiHuiFudata.h"

#import "WSFSlideTitlesView.h"
#import "LYHTTPClient.h"


#define  screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]

@interface MeXiaoXiController()<UITableViewDelegate,UITableViewDataSource,WSFSlideTitlesViewDelegate>

@property (nonatomic, strong) NSArray *dataFrames;
@property (nonatomic, strong) NSArray *dataFrames2;
@property (nonatomic,assign)BOOL selectionFlag;

@property(nonatomic,weak) WSFSlideTitlesView *slideView;
@property(nonatomic,weak) UITableView *tableView;


@property (nonatomic,strong)NSArray *message;
@property (nonatomic,strong)NSArray *replyMessage;


@end


@implementation MeXiaoXiController


-(void)viewDidLoad {
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, screenB.size.width, screenB.size.height - 40) style:UITableViewStyleGrouped];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"我的消息";
    tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 10)];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    _tableView = tableview;
    [self settingWSFSlideView];
}



-(void)netWorkAsking {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefault valueForKey:kUserId];
    NSString *url1 = @"http://192.168.0.135:8080/ws/rest/teacher/getChatRecordList/";
    NSString *url2 = @"http://192.168.0.135:8080/ws/rest/teacher/getReplyChatList/";
    NSDictionary *para1 = @{@"sourceUserId":userId};
    [LYHTTPClient POST:url1 parameters:para1 cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *message = [NSArray new];
        message = responseObject;
        _message = message;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    [LYHTTPClient POST:url2 parameters:para1 cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *replyMessage = [NSArray new];
        replyMessage = responseObject;
        _replyMessage = replyMessage;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


//ME ADD
-(void)settingWSFSlideView{
    
    
    WSFSlideTitlesViewSetting *titlesSetting = [[WSFSlideTitlesViewSetting alloc] init];
    
    titlesSetting.titlesArr = @[@"已发送",@"已回复"];
    titlesSetting.frame = CGRectMake(0, 0, screenB.size.width , 40);
    //    titlesSetting.lineWidth = screenB.size.width / titlesSetting.titlesArr.count ;
    titlesSetting.lineHeight = 2;
    titlesSetting.isFullDisplay = NO;
    titlesSetting.lineColor = color(245, 76, 73, 1);
    titlesSetting.animateDuration = 0.3;
    
    titlesSetting.backgroundColor = [UIColor whiteColor];
    
    titlesSetting.selectedTextColor = color(245, 76, 73, 1);
    titlesSetting.textColor = [UIColor blackColor];
    // 通过设置创建 WSFSlideTitlesView
    titlesSetting.textFontSize = 16;
    WSFSlideTitlesView *titlesView = [[WSFSlideTitlesView alloc] initWithSetting:titlesSetting];
    
    titlesView.delegate = self;
    _slideView = titlesView;
    [_slideView selectButtonAtIndex:0 action:NO];
    [self.view addSubview:titlesView];
    
}


#pragma mark - slideview delegate

-(void)slideTitlesView:(WSFSlideTitlesView *)titlesView didSelectButton:(UIButton *)button atIndex:(NSUInteger)index {
    NSLog(@"点击了第%li个按钮",index);
    if (index == 0) {
        _selectionFlag = NO;
    }
    else
    {
        _selectionFlag = YES;
    }
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    NSUInteger ii[2] = {0, 0};
//    NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}



-(NSArray *)dataFrames
{
    if (_dataFrames == nil) {
        // 初始化
        // 1.获得plist的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"xiaoxiXQ.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            
            xiaoxiXQdata   *status = [xiaoxiXQdata xiaoxiXQWithDictionary:dict];
            
            
            xiaoxiXQ *statusFrame = [[xiaoxiXQ alloc] init];
            statusFrame.xxXQ = status;
            
            
            [statusFrameArray addObject:statusFrame];
        }
        
        // 4.赋值
        _dataFrames = statusFrameArray;
    }
    return _dataFrames;
}


-(NSArray *)dataFrames2{
    if (!_dataFrames2) {
        // 初始化
        // 1.获得plist的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"xiaoxihuifu.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            
            XiaoXiHuiFudata   *status = [XiaoXiHuiFudata XiaoXiHuiFuWithDictionary:dict];
            
            
            XiaoXiHuiFu *statusFrame = [[XiaoXiHuiFu alloc] init];
            statusFrame.xxHF = status;
            
            [statusFrameArray addObject:statusFrame];
        }
        
        // 4.赋值
        _dataFrames2 = statusFrameArray;
    }
    
    return _dataFrames2;
}


#pragma mark - Table View Datasourse and delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    if (!self.selectionFlag) {
        return self.dataFrames.count;
    }
    else
    {
    return self.dataFrames2.count;
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   return  YES;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.selectionFlag) {
        xiaoxiXQTableViewCell *cell = [xiaoxiXQTableViewCell xiaoxiYQcellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.xxXQmodel = self.dataFrames[indexPath.row];
        return cell;
    }
    else
    {
       XiaoXiHuiFuCell  *cell = [XiaoXiHuiFuCell XiaoXiHuiFucellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.xxHFmodel = self.dataFrames2[indexPath.row];
        return cell;
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.selectionFlag) {
        xiaoxiXQ *statusFrame = self.dataFrames[indexPath.row];
        return statusFrame.cellHeight;
    }
    else
    {
        XiaoXiHuiFu *statusFrame = self.dataFrames2[indexPath.row];
        return statusFrame.cellHeight;

    }

}




@end
