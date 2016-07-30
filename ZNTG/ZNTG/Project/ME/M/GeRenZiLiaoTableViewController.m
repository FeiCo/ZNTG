//
//  GeRenZiLiaoTableViewController.m
//  testtest
//
//  Created by Peter Hu on 16/7/29.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "GeRenZiLiaoTableViewController.h"
#import "UIImage+SuoFang.h"

#import "GenderTableViewController.h"
#import "TextFieldTableViewController.h"

@interface GeRenZiLiaoTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation GeRenZiLiaoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 10)];
    self.title = @"个人资料";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)pickImageFromAlbum {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController  alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        NSLog(@"already opened photolibary");
    }];
    
}


-(void)imageFromCamera {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController  alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        NSLog(@"already opened camera");
    }];
}


#pragma mark - 选择图片后的回调方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info  {
    NSLog(@"ddd0");
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    UIImage *  theImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(120.0, 120.0)];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



-(void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 9;
    }
    else
    {
    return 1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 90;
        }
        else if(indexPath.row == 8){
        return 80;
        }
        else
        {
            return 44;
        }
    }
    else return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *id ;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    if (indexPath.section == 0) {

    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"头像";
            cell.textLabel.textColor = [UIColor grayColor];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 90, 20, 50, 50)];
            imageV.layer.cornerRadius = 25;
            imageV.layer.masksToBounds = YES;
            imageV.image = [UIImage imageNamed:@"Default_Avatar"];
            [cell.detailTextLabel addSubview:imageV];
            [cell.contentView addSubview:imageV];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.detailTextLabel.text = @"dcdccdd";
            break;
        }
        case 1:
            cell.textLabel.text = @"昵称";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @"xxxx";
            break;
        case 2:
            cell.textLabel.text = @"性别";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"男";
            break;
        case 3:
            cell.textLabel.text = @"年龄";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @"30";
            break;
        case 4:
            cell.textLabel.text = @"地址";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @"山西";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 5:
            cell.textLabel.text = @"职业";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @"智能顾问";
            break;
        case 6:
            cell.textLabel.text = @"学历";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @"大学本科";
            break;
        case 7:
            cell.textLabel.text = @"QQ";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @"99999999";
            break;
        case 8:
        {
            UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, [UIScreen mainScreen].bounds.size.width -120, 60)];
            detailLabel.text = @"今天心情真的很不错，很不错，很不错，很不错，很不错";
            detailLabel.font =[UIFont systemFontOfSize:14];
            detailLabel.numberOfLines = 2;
            cell.textLabel.text = @"个性签名";
            cell.textLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:detailLabel];
            break;
        }
        default:
            break;
    }
    
  }
    else
    {
        UITableViewCell *cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
        cell1.textLabel.text = @"退出登录";
        cell1.textLabel.textColor = [UIColor redColor];
        cell1.textLabel.font = [UIFont systemFontOfSize:18];
        cell1.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell1;
    }
    

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    __weak typeof (self) weakself = self;
    if (indexPath.section == 0) {

        if (indexPath.row == 0) {
            
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancell = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *lab = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakself pickImageFromAlbum];
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [weakself imageFromCamera];
    }];
    
    [alertCon addAction:cancell];
    [alertCon addAction:lab];
    [alertCon addAction:camera];
    
    [self presentViewController:alertCon animated:YES completion:^{
        
    }];
            
    }
        else if (indexPath.row == 2)
        {
            GenderTableViewController *genderCon = [GenderTableViewController GenderControllerWithMale:YES];
            [self.navigationController pushViewController:genderCon animated:YES];
        }
        else if (indexPath.row == 4)
        {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleField defaultText:@"山西" keyBoardType:TextTableViewKeyBoardTypeNormal andWordLimit:11];
            
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
        else if (indexPath.row == 8) {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleView defaultText:@"今天心情真的很不错，很不错，很不错，很不错，很不错" keyBoardType:TextTableViewKeyBoardTypeNormal andWordLimit:100];
            
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
    }
    
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
