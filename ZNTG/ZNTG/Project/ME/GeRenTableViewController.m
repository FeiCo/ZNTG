//
//  GeRenTableViewController.m
//  ZNTG客户端
//
//  Created by Peter on 5/26/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "GeRenTableViewController.h"
//#import "shezhiTableViewController.h"
#import "dengLuViewController.h"
//#import "dengLuViewController.h"

//#import "MSBannerModel.h"
//#import "MSBannerController.h"


#import "GeRenZiLiaoTableViewController.h"
#import "ZhangHuAnQuanTableViewController.h"
#import "JiaoYiJiLuTableViewController.h"
#import "GouMaiFWTableViewController.h"
#import "MeXiaoXiController.h"

#import "UIImageView+WebCache.h"

#define screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]


@interface GeRenTableViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIImageView *txImageV;
@property (nonatomic,weak) UIImageView *headerView;
@property (nonatomic,weak) UILabel *nameL;
@property (nonatomic,weak) CALayer *teXiao;



@property(nonatomic,strong)NSString *link1;
@property(nonatomic,strong)NSString *link2;
@property(nonatomic,strong)NSString *link3;
@property(nonatomic,strong)NSString *link4;

@property(nonatomic,assign)NSString *islogedin;



@end

@implementation GeRenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买服务";
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.tableView.backgroundColor = color(241, 242, 243, 1);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(170, 0, 0, 0);
    self.navigationController.navigationBar.translucent = NO;
    
    [self setHeaderView];
    [self setHeaderButtonView
     ];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{

[self.navigationController setNavigationBarHidden:YES animated:NO];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userState = [userDefaults objectForKey:kUserLoginState];
    NSString *userNickName = [userDefaults objectForKey:kUserNickName];
//    NSString *userImageUrl = [userDefaults objectForKey:kUserNickName];
    _islogedin = userState;
    if(_islogedin &&[_islogedin isEqualToString:@"YES"]){
        _nameL.text = userNickName;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *iconString = [userDefaults valueForKey:@"meavatar"];
        if (iconString) {
            _txImageV.image = [self getImage:iconString];
        }
        else
        {
            _txImageV.image = [UIImage imageNamed:@"Default_Avatar1"];
            
        }

    }
    else
    {
       _txImageV.image = [UIImage imageNamed:@"Default_Avatar1"];
        _nameL.text = @"请登录";
    }

}


- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}


-(void)setHeaderView {
    
    UIImageView *backgroundview = [[UIImageView alloc]initWithFrame: CGRectMake(0, - 170, screenB.size.width, 170)];
    
    backgroundview.image = [UIImage imageNamed:@"MEbackground"];
    backgroundview.contentMode = UIViewContentModeScaleAspectFill;
    backgroundview.backgroundColor = color(242, 80, 43, 1);
    
    
    UIImageView *iconP = [[UIImageView alloc]initWithFrame:CGRectMake((screenB.size.width - 60)/2, 70, 60, 60)];
    
    iconP.layer.cornerRadius = 30;
    iconP.layer.borderColor = [UIColor whiteColor].CGColor;
    iconP.layer.borderWidth = 2;
    iconP.layer.masksToBounds = YES;
    
    
    UILabel *name = [[UILabel  alloc]initWithFrame:CGRectMake((screenB.size.width - 200)/2, 137, 200, 20)];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont systemFontOfSize:13];
    name.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton *shezhi = [UIButton buttonWithType:UIButtonTypeSystem];
    [shezhi setImage:[UIImage imageNamed: @"icon-sezhi"] forState:UIControlStateNormal];
    [shezhi setTitle:@"个人中心" forState:UIControlStateNormal];
    shezhi.titleLabel.font = [UIFont systemFontOfSize:16];
    shezhi.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    
    
    shezhi.frame = CGRectMake((screenB.size.width - 80)/2, 25, 80, 40);
    [shezhi setTintColor:[UIColor whiteColor]];
    [shezhi addTarget:self action:@selector(sheZhiBClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTeXiaoQuan:iconP];
    
    
    [backgroundview addSubview:iconP];
    [backgroundview addSubview:name];
    [backgroundview addSubview:shezhi];
    _headerView = backgroundview;
    _txImageV = iconP;
    _nameL = name;
    
    iconP.userInteractionEnabled = YES;
    backgroundview.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)];
    tap.numberOfTapsRequired = 1;
    [iconP addGestureRecognizer:tap];
    [self.tableView insertSubview:backgroundview atIndex:0];
//    [self.tableView addSubview:backgroundview];
    
}


-(void)iconClick {
    
    if(_islogedin&&[_islogedin isEqualToString:@"YES"]){

    }
    else
    {
        dengLuViewController *dengluC = [[dengLuViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:dengluC];
        
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }
}


-(void)sheZhiBClick{
    NSLog(@"CLICK");
//    shezhiTableViewController *szController = [[shezhiTableViewController alloc] init];

        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:szController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}





-(void)setHeaderButtonView {

    UIView *headerV =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 10)];
    headerV.backgroundColor = color(239, 239, 244, 1);
    self.tableView.tableHeaderView = headerV;

}


-(void)click:(id) seder {
    
    NSLog(@"dddd");
//    [self setNeedsStatusBarAppearanceUpdate];
}


-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 0.1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"MEgeren"];
            cell.textLabel.text = @"个人资料";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            return cell;
        }
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"MEanquan"];
            cell.textLabel.text = @"账户与安全";
            return cell;
        }
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"MEjiaoyi"];
            cell.textLabel.text = @"交易记录";
            return cell;
        }
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"MEgmfw"];
            cell.textLabel.text = @"购买服务";
            return cell;
        }
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"MExiaoxi"];
            cell.textLabel.text = @"我的消息";
            UIView *reddot = [[UIView alloc]initWithFrame:CGRectMake(screenB.size.width - 45,18 , 8, 8)];
            reddot.layer.cornerRadius = 4;
            reddot.backgroundColor =[UIColor redColor];
            [cell.contentView addSubview:reddot];
            return cell;
        }
        
        case 5:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"sel_Friends"];
            cell.textLabel.text = @"邀请好友";
            return cell;
        }
        case 6:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"sel_authentication"];
            cell.textLabel.text = @"申请认证";
            return cell;
        }
        default:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"sel_contact"];
            cell.textLabel.text = @"联系我们";
            return cell;
        }

    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loginstate = [userDefaults valueForKey:kUserLoginState];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (loginstate && [loginstate isEqualToString:@"YES"]) {
     self.hidesBottomBarWhenPushed = YES;
    switch (indexPath.row) {
        case 0:
        {
            GeRenZiLiaoTableViewController *geRenZiLiao = [[GeRenZiLiaoTableViewController alloc]init];
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:geRenZiLiao animated:YES];
            break;
        }
        case 1:
        {
            ZhangHuAnQuanTableViewController *zhangHuAnQuan =[[ZhangHuAnQuanTableViewController alloc]init];
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:zhangHuAnQuan animated:YES];
            break;
        }
        case 2:
        {
            JiaoYiJiLuTableViewController *jiaoYiJL = [[JiaoYiJiLuTableViewController alloc]init];
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:jiaoYiJL animated:YES];
            break;
        }
        case 3:
        {
            GouMaiFWTableViewController *gouMaiFW = [[GouMaiFWTableViewController alloc]init];
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:gouMaiFW animated:YES];
            break;
        }
        default:
        {
            MeXiaoXiController *meXiaoXi = [[MeXiaoXiController alloc]init];
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:meXiaoXi animated:YES];
            break;
        }
    }
    self.hidesBottomBarWhenPushed = NO;
  }
    else
    {
        dengLuViewController *dengluC = [[dengLuViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:dengluC];
        
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }
}

#pragma mark - scrollview delegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"dddd%f",scrollView.contentOffset.y + 170);
    CGFloat zero = scrollView.contentOffset.y + 170;
    
    CGRect tempt1 = CGRectMake(0, -170, screenB.size.width, 170);
    CGRect tempt2 = CGRectMake((screenB.size.width - 60)/2, 70, 60, 60);
    CGRect tempt3 = CGRectMake((screenB.size.width - 200)/2, 137, 200, 20);
    
    CGRect tempt2bounds = CGRectMake(0, 0, 60, 60);
    
    if ( zero < -0.5) {
        
        CGFloat scalefactor = zero / 60;
        
        tempt2bounds.size.width  = 60 * (1 - scalefactor);
        tempt2bounds.size.height = 60 * (1 - scalefactor);
        
        [_teXiao removeFromSuperlayer];
        
        tempt1.origin.y += zero;
        tempt1.size.height -= zero;
        _headerView.frame = tempt1;
       
    
        tempt2.origin.y -= zero / 2;
        
        tempt3.origin.y -= zero;
        
        _txImageV.frame = tempt2;
        _txImageV.bounds = tempt2bounds;
        _txImageV.layer.cornerRadius = 30 * (1 - scalefactor);
        [self setTeXiaoQuan:_txImageV];
        
        _nameL.frame = tempt3;
        
         NSLog(@"aaaa%f",_txImageV.frame.origin.x);
        NSLog(@"aaaa%f",_txImageV.frame.size.width);
    }
    else if (-0.5 < zero || zero < 2 )
    {
      
        _headerView.frame = tempt1;
        _txImageV.frame = tempt2;
        _txImageV.bounds = tempt2bounds;
        _nameL.frame = tempt3;
       
        
    }
    

}


-(void) setTeXiaoQuan:(UIImageView *)imageV {
    
    //阴影图层
    CALayer *layerShadow=[[CALayer alloc]init];
    
    layerShadow.frame = CGRectMake(0, 0, imageV.bounds.size.width, imageV.bounds.size.height);
    layerShadow.cornerRadius = imageV.layer.cornerRadius;
    layerShadow.shadowColor = [UIColor yellowColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(0, 0);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = 1;
    [imageV.layer addSublayer:layerShadow];
    _teXiao = layerShadow;
    
//    [_teXiao setNeedsDisplay];
    
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
