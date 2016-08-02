//
//  TeacherViewController.m
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#import "TeacherViewController.h"
#import "TeacherCell.h"
#import "TeacherList.h"

@interface TeacherViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation TeacherViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"名师";
    [self initializeTableView];
    [self requestsTeacherList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self registerNib];
}

- (void)registerNib {
    [_tableView registerNib:[UINib nibWithNibName:@"TeacherCell" bundle:nil] forCellReuseIdentifier:@"TeacherCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TeacherCell";
    TeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    TeacherList *teacherList = [_dataList objectAtIndex:indexPath.row];
    [cell handleTeacherCellWithIcon:teacherList.photoLocation
                               name:teacherList.name
                         levelImage:nil
                         levelLabel:teacherList.certificateNo
                          introduce:teacherList.descriptions];
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenHeightScale(152);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenHeightScale(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"111111");
}

#pragma mark - Network Requests

- (void)requestsTeacherList {
    NSString *urlString = @"http://192.168.0.135:8080/ws/rest/teacher/getTeacherList/*";
    [MSNetRequest requestMethodsWithPOST:nil url:urlString successBlock:^(id responseObject) {
        
        NSDictionary *jsonDictionary = [responseObject jsonValueDecoded];
        NSDictionary *resultData = [jsonDictionary objectForKey:@"resultData"];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:resultData.count];
        NSLog(@"resultData:%@",resultData);
        for (NSDictionary *dict in resultData) {
            [tempArray addObject:[TeacherList teacherListFromDictionry:dict]];
        }
        _dataList = [NSArray arrayWithArray:tempArray];
        [_tableView reloadData];
        
    } failureBlock:^(NSString *err) {
        NSLog(@"err:%@",err);
    }];
}


@end
