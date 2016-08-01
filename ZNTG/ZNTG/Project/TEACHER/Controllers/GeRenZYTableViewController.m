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

#define screenB   [UIScreen mainScreen].bounds

@interface GeRenZYTableViewController ()


@end

@implementation GeRenZYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:   UITableViewStyleGrouped];
    [self settingTableHeader];
}




-(void)settingTableHeader{
    UIView *backHeaderV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 410)];
    GeRHeader *geren = [GeRHeader GeRHeader];
    [geren setWithName:@"何燕华" title:@"金牌投顾"  corp:@"上海新兰德"  signature:@"大家好，我是xxx"  jianJie:@"大家大家好大家大家好"  fans:@"粉丝:345"  purchaseCount:@"购买:34"];
    [backHeaderV addSubview:geren];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blueColor];
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor yellowColor];
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor blackColor];
    
    NSArray *views = [[NSArray alloc] initWithObjects:view1,view2,view3,view4,nil];
    
    NSArray *title = @[@"胜赢",@"智赢",@"慧赢",@"私人订制"];
    YFViewPager *pager = [[YFViewPager alloc] initWithFrame:CGRectMake(0, 210, screenB.size.width, 200) titles:title icons:nil selectedIcons:nil views:views];
    pager.showAnimation = NO;
    pager.tabTitleColor = [UIColor blackColor];
    pager.tabSelectedTitleColor = [UIColor redColor];
    pager.tabSelectedArrowBgColor =[UIColor redColor];
    [backHeaderV addSubview:pager];
    
    self.tableView.tableHeaderView = backHeaderV;


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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
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

@end
