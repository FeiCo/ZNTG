//
//  SingleSelectionController.m
//  ZNTG
//
//  Created by Peter on 8/10/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "SingleSelectionController.h"

@interface SingleSelectionController ()

@property (nonatomic,strong) NSArray *dataArra;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,copy) NSString * id;

@end

@implementation SingleSelectionController


-(void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *str = _dataArra[_selectedIndex];
    [userDefault setValue:str forKey:_id];
}



+(instancetype)singleSelectionWithDataArray:(NSArray *)arra
                           intialValueIndex:(NSInteger)index
                              andIdentifier:(NSString *)id {
    SingleSelectionController  *controller = [[SingleSelectionController alloc] init];
    controller.dataArra = arra;
    controller.selectedIndex = index;
    controller.id = id;
    return controller;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 10)];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArra.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = _dataArra[indexPath.row];
    if (indexPath.row == _selectedIndex) {
                   cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *lastindexpath = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:lastindexpath];
    
    selectedCell.accessoryType = UITableViewCellAccessoryNone;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectedIndex = indexPath.row;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
