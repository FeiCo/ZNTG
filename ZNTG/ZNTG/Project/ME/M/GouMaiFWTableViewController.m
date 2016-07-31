//
//  GouMaiFWTableViewController.m
//  testtest
//
//  Created by Peter Hu on 16/7/30.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "GouMaiFWTableViewController.h"
#import "GouMaiFWTableViewCell.h"

@interface GouMaiFWTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yanhuangL;
@property (weak, nonatomic) IBOutlet UILabel *shijianLabel;
@property (weak, nonatomic) IBOutlet UIButton *chakanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageV;


@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation GouMaiFWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSArray *)dataArray {
    NSArray *arra = [NSArray new];
    if (!_dataArray) {
       
        NSString *path = [[NSBundle mainBundle]pathForResource:@"GuoMaiFW.plist" ofType:nil];
        arra = [NSArray arrayWithContentsOfFile:path];
        _dataArray = arra;
    }
    return _dataArray;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GouMaiFWTableViewCell";
    [self settingDataFromIndexpath:indexPath];
    GouMaiFWTableViewCell *cell = (GouMaiFWTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell= (GouMaiFWTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"GouMaiFWTableViewCell" owner:self options:nil]  lastObject];
    }
    // 自己的一些设置
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}


-(void)settingDataFromIndexpath:(NSIndexPath *)indexpath {
    _backGroundImage.image = [UIImage imageNamed:[self.dataArray[indexpath.section] valueForKey:@"backGround"]];
    _tagImageV.image = [UIImage imageNamed:[self.dataArray[indexpath.section] valueForKey:@"tagGround"]];
    _nameLabel.text = [self.dataArray[indexpath.section] valueForKey:@"name"];
    _yanhuangL.text = [self.dataArray[indexpath.section] valueForKey:@"yanhuang"];
    _shijianLabel.text = [self.dataArray[indexpath.section] valueForKey:@"shijan"];
    _chakanBtn.layer.cornerRadius = 2;

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}


- (IBAction)clickBtn:(id)sender {
    
    NSLog(@"sdsdsdasdaad");
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
