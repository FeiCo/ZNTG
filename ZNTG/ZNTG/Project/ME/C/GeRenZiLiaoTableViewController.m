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

#import "UIImageView+WebCache.h"

#import "MSNetRequest.h"
#import "JSONKit.h"

#import "SingleSelectionController.h"
#import "LYHTTPClient.h"

@interface GeRenZiLiaoTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,copy)NSString *imageurl;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSString *age;
@property(nonatomic,copy)NSString *adress;
@property(nonatomic,copy)NSString *profession;
@property(nonatomic,copy)NSString *education;
@property(nonatomic,copy)NSString *qqnum;
@property(nonatomic,copy)NSString *signature;

@property(nonatomic,copy)NSString *token;
@property(nonatomic,weak)UIImageView *iconV;

@end

@implementation GeRenZiLiaoTableViewController


-(void)dealloc {
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [usrDefault valueForKey:kUserToken];
    NSString *usrId = [usrDefault valueForKey:kUserId];
    NSString *zhiye = [usrDefault valueForKey:kUserZhiye];
    NSString *xueli = [usrDefault valueForKey:kUserXueli];
    NSString *age = [usrDefault valueForKey:kUserAge];
    NSString *qq = [usrDefault valueForKey:kUserQq];
    NSString *address = [usrDefault valueForKey:kUserAdress];
    NSString *gender = [usrDefault valueForKey:kUserGender];
    NSString *autograph = [usrDefault valueForKey:kUserAutoGraph];
    NSString *nickname = [usrDefault valueForKey:kUserNickName];
    NSDictionary *para = @{@"nickname":nickname,@"gender":gender,@"autograph":autograph,@"token":token,@"userid":usrId,@"age":age,@"address":address,@"zhiye":zhiye,@"xueli":xueli,@"QQ":qq};
    [LYHTTPClient POST:kGetUserEdit parameters:para cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 10)];
    self.title = @"个人资料";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *iconString = [userDefaults valueForKey:kUserImage];
    NSString *nickName = [userDefaults valueForKey:kUserNickName];
    NSString *token = [userDefaults valueForKey:kUserToken];
    NSString *signature = [userDefaults valueForKey:kUserAutoGraph];
    NSString *gender = [userDefaults valueForKey:kUserGender];
    NSString *age = [userDefaults valueForKey:kUserAge];
    NSString *adress = [userDefaults valueForKey:kUserAdress];
    NSString *profession = [userDefaults valueForKey:kUserZhiye];
    NSString *xueli = [userDefaults valueForKey:kUserXueli];
    NSString *qq = [userDefaults valueForKey:kUserQq];
    
    _imageurl = iconString;
    _nickname = nickName;
    _token = token;
    _signature = signature;
    
    _gender = gender;
    _age = age;
    _adress = adress;
    _profession = profession;
    _education = xueli;
    _qqnum = qq;

    //    _link1 = [userDefaults objectForKey:KPersonCenterValue1];
    //    _link2 = [userDefaults objectForKey:KPersonCenterValue2];
    //    _link3 = [userDefaults objectForKey:KPersonCenterValue3];
    //    _link4 = [userDefaults objectForKey:KPersonCenterValue4];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *signature = [userDefaults valueForKey:kUserAutoGraph];
    NSString *gender = [userDefaults valueForKey:kUserGender];
    NSString *age = [userDefaults valueForKey:kUserAge];
    NSString *adress = [userDefaults valueForKey:kUserAdress];
    NSString *profession = [userDefaults valueForKey:kUserZhiye];
    NSString *xueli = [userDefaults valueForKey:kUserXueli];
    NSString *qq = [userDefaults valueForKey:kUserQq];
    NSString *nickname = [userDefaults valueForKey:kUserNickName];

    _signature = signature;
    _gender = gender;
    _age = age;
    _adress = adress;
    _profession = profession;
    _education = xueli;
    _qqnum = qq;
    _nickname = nickname;
    [self.tableView reloadData];
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
    UIImage *  theImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(500.0, 500.0)];
    [self saveImage:theImage WithName:@"avatar"];
    _iconV.image = theImage;
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [imageData writeToFile:fullPathToFile atomically:NO];
    [userDefaults setValue:fullPathToFile forKey:@"meavatar"];
    [userDefaults synchronize];
}


- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
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
              _iconV = imageV;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSString *iconString = [userDefaults valueForKey:@"meavatar"];
                if (iconString) {
                     imageV.image = [self getImage:iconString];
                }
                else
                {
                imageV.image = [UIImage imageNamed:@"Default_Avatar1"];
                }
            [cell.detailTextLabel addSubview:imageV];
            [cell.contentView addSubview:imageV];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.detailTextLabel.text = @"dcdccdd";
            break;
        }
        case 1:
            cell.textLabel.text = @"昵称";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = _nickname;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.textLabel.text = @"性别";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = _gender;
            break;
        case 3:
            cell.textLabel.text = @"年龄";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = _age;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 4:
            cell.textLabel.text = @"地址";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = _adress;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 5:
            cell.textLabel.text = @"职业";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = _profession;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 6:
            cell.textLabel.text = @"学历";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = _education;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 7:
            cell.textLabel.text = @"QQ";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = _qqnum;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 8:
        {
            UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, [UIScreen mainScreen].bounds.size.width -120, 60)];
            NSString *str = [_signature stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if(!_signature||[str isEqualToString:@""])
            {
               detailLabel.text = @"请设置个性签名";
            }
            else
            {
              detailLabel.text = _signature;
            }
            
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
    self.hidesBottomBarWhenPushed = YES;
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
        else if (indexPath.row == 1)
        {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleField defaultText:_nickname keyBoardType:TextTableViewKeyBoardTypeNormal andWordLimit:11 andIdentifier:kUserNickName];
            
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
        else if (indexPath.row == 2)
        {
            BOOL ismale = [_gender isEqualToString:@"女"] ?  NO: YES;
            GenderTableViewController *genderCon = [GenderTableViewController GenderControllerWithMale:ismale];
            [self.navigationController pushViewController:genderCon animated:YES];
        }
        else if (indexPath.row == 3)
        {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleField defaultText:_age keyBoardType:TextTableViewKeyBoardTypeNumber andWordLimit:5 andIdentifier:kUserAge];
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
        else if (indexPath.row == 4)
        {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleField defaultText:_adress keyBoardType:TextTableViewKeyBoardTypeAdreessPicker andWordLimit:11 andIdentifier:kUserAdress];
            
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
        else if (indexPath.row == 5)
        {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleField defaultText:_profession keyBoardType:TextTableViewKeyBoardTypeNormal andWordLimit:11 andIdentifier:kUserZhiye];
            
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
        else if (indexPath.row == 6)
        {
            NSArray *arra = @[@"初中",@"高中",@"专科",@"大学",@"硕士"];
            NSInteger index =[self getStringIndex:_education fromArray:arra];
           SingleSelectionController  *jiaoyu = [SingleSelectionController singleSelectionWithDataArray:arra intialValueIndex:index andIdentifier:kUserXueli];
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
        else if (indexPath.row == 7)
        {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleField defaultText:_qqnum keyBoardType:TextTableViewKeyBoardTypeNumber andWordLimit:11 andIdentifier:kUserQq];
            
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
        else if (indexPath.row == 8) {
            TextFieldTableController *jiaoyu = [TextFieldTableController TextFieldControllerWithType:TextTableViewStyleView defaultText:_signature keyBoardType:TextTableViewKeyBoardTypeNormal andWordLimit:100 andIdentifier:kUserAutoGraph];
            [self.navigationController pushViewController:jiaoyu animated:YES];
        }
    }
    else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:@"NO" forKey:kUserLoginState];
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"您要退出吗" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancell = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *lab = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [weakself quitLogin];
        }];
        

        [alertCon addAction:cancell];
        [alertCon addAction:lab];
        
        [self presentViewController:alertCon animated:YES completion:^{
            
        }];

    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)quitLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults valueForKey:kUserId];
    NSString *token = [userDefaults valueForKey:kUserToken];
    
    NSDictionary *para = @{@"userid":userid,@"token":token};
    [MSNetRequest requestMethodsWithPOST:para url:kLogOut successBlock:^(id responseObject) {

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDictionary = [jsonString objectFromJSONStringWithParseOptions:JKSerializeOptionPretty];
        NSNumber *type = [jsonDictionary objectForKey:@"type"];
        if (type.integerValue == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failureBlock:^(NSString *err) {
        
    }];
   [userDefaults setValue:@"NO" forKey:kUserLoginState];
}


#pragma mark - utilities

-(NSInteger)getStringIndex:(NSString *)str fromArray:(NSArray *)arra {
    NSInteger index = 0;
    for (int i=0; i<arra.count; i++) {
        if ([arra[i] isEqualToString:str]) {
            index = i;
        }
    }
    return index;
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
