//
//  GeRenZYTableViewController.m
//  NeiYE
//
//  Created by Peter on 8/1/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "GeRenZYTableViewController.h"
#import "YFViewPager.h"
#import "GeRHeader.h"

#import "ClassCubeTableViewCell.h"
#import "MediaPlayerViewController.h"
#import "CustomAlertView.h"

#import "LYHTTPClient.h"

#define screenB   [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]

@interface GeRenZYTableViewController ()<ClassCubeImageClickdelegate>
@property (nonatomic,strong) NSMutableArray *xxdataarray;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation GeRenZYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:   UITableViewStyleGrouped];
    [self settingTableHeader];
}


-(void)networkAsking {
    NSString *url = @"http://192.168.0.135:8080/ws/rest/teacher/getTeacherInfo/";
    NSDictionary *dict = @{@"teacherId":_teacherId};
    [LYHTTPClient POST:url parameters:dict cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *tempt = [NSArray new];
        tempt = responseObject;
        _dataArray = tempt;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}



-(NSMutableArray *)xxdataarray {
    if (!_xxdataarray) {
        
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"tempt.plist" ofType:nil];
        NSMutableArray *dictArray2 = [NSMutableArray arrayWithContentsOfFile:path2];
        
        
        _xxdataarray = dictArray2;
    }
    return _xxdataarray;
}


-(void)backBTNClick {
    NSLog(@"fffff");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)lookBTNClick {
    NSLog(@"fffff");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)focusBTNClick:(UIButton *)sender {
    [sender setEnabled:NO];
}



-(void)settingTableHeader{
    UIView *backHeaderV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 425)];
    GeRHeader *geren = [GeRHeader GeRHeader];
    [geren setWithName:@"何燕华" title:@"金牌投顾"  corp:@"上海新兰德"  signature:@"大家好，我是xxx"  jianJie:@"大家大家好大家大家好"  fans:@"粉丝:345"  purchaseCount:@"购买:34"];
    [backHeaderV addSubview:geren];
    [geren.backBTN addTarget:self action:@selector(backBTNClick) forControlEvents:UIControlEventTouchUpInside];
    [geren.focusBTN addTarget:self action:@selector(focusBTNClick:) forControlEvents:UIControlEventTouchUpInside];
    [geren.lookBTN addTarget:self action:@selector(lookBTNClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *dic1 = @{@"yuan":@"168",@"ren":@"147",@"content":@"以技术层面为主，以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主"};
    NSDictionary *dic2 = @{@"yuan":@"118",@"ren":@"147",@"content":@"以技术层面为主，以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主"};
    NSDictionary *dic3 = @{@"yuan":@"218",@"ren":@"1677",@"content":@"以技术层面为主，以技术层面技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主"};
    
    NSDictionary *dic4 = @{@"tel":@"4000607176",@"content":@"以技术层面为主，以技术层面技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主以技术层面为主"};
    
    
    UIView *view1 = [self getViewStyle2With:dic1];
    UIView *view2 = [self getViewStyle2With:dic2];
    UIView *view3 = [self getViewStyle2With:dic3];
    UIView *view4 = [self getViewStyle1With:dic4];
    NSArray *views = [[NSArray alloc] initWithObjects:view1,view2,view3,view4,nil];
    
    NSArray *title = @[@"胜赢",@"智赢",@"慧赢",@"私人订制"];
    YFViewPager *pager = [[YFViewPager alloc] initWithFrame:CGRectMake(0, 210, screenB.size.width, 215) titles:title icons:nil selectedIcons:nil views:views];
    pager.showAnimation = NO;
    pager.tabTitleColor = [UIColor blackColor];
    pager.tabSelectedTitleColor = [UIColor redColor];
    pager.tabSelectedArrowBgColor =[UIColor redColor];
    [backHeaderV addSubview:pager];
    
    self.tableView.tableHeaderView = backHeaderV;


}


-(UIView *)getViewStyle1With:(NSDictionary *)dict {
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenB.size.width - 20, 40)];
    
    NSString *tel = [dict valueForKey:@"tel"];
    NSString *contentstr = [dict valueForKey:@"content"];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, screenB.size.width - 20, 70)];
    content.text = contentstr;
    content.numberOfLines = 3;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:tel forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame =CGRectMake(40, 125, screenB.size.width - 80, 40);
    btn.layer.cornerRadius = 3;
    [view addSubview:titleL];
    [view addSubview:content];
    [view addSubview:btn];
    return  view;
}



-(UIView *)getViewStyle2With:(NSDictionary *)dict {
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenB.size.width - 20, 40)];
    
    NSString *yuan = [dict valueForKey:@"yuan"];
    yuan = [yuan stringByAppendingString:@"元"];
    NSString *ren = [dict valueForKey:@"ren"];
    NSString *contentstr = [dict valueForKey:@"content"];
    
    NSString *huidazhe = [NSString stringWithFormat:@"%@已有%@人购买",yuan,ren];
    NSRange range = [yuan rangeOfString:yuan];
    NSRange range1 = [huidazhe rangeOfString:ren];
    NSMutableAttributedString *huiDa =[[NSMutableAttributedString alloc] initWithString:huidazhe];
    huiDa.font = [UIFont systemFontOfSize:14];
    [huiDa addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:242 / 255.0 green:79 / 255.0 blue:66 / 255.0 alpha:1] range:range];
    [huiDa addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:246 / 255.0 green:172 / 255.0 blue:68 / 255.0 alpha:1] range:range1];
    [huiDa addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
    
    titleL.attributedText = huiDa;
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, screenB.size.width - 20, 70)];
    content.text = contentstr;
    content.numberOfLines = 3;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"立即购买" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame =CGRectMake(40, 125, screenB.size.width - 80, 40);
    btn.layer.cornerRadius = 3;
    [view addSubview:titleL];
    [view addSubview:content];
    [view addSubview:btn];
    return  view;
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
    
    return 8;
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
        NSURL *usl = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14564977406580.mp4"];
        mediaPlayer.videoURL = usl;
        [self.navigationController pushViewController:mediaPlayer animated:YES];
    } rightBlock:^{
        NSLog(@"购买");
    } dismissBlock:^{
        NSLog(@"取消");
    }];
}



@end
