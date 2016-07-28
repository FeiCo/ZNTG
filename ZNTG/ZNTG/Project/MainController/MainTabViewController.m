//
//  MainTabViewController.m
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#import "MainTabViewController.h"
#import "Constants.h"


@interface MainTabViewController ()
@property (nonatomic, strong) NSArray * nameArra;
@property (nonatomic, strong) NSArray * imageArra;
@property (nonatomic, strong) NSArray * imageArraSel;
@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self setTabBar];
}

-(void)setTabBar{
    _nameArra = @[KHomeTitle,KTeacherTitle,KClassTitle,KMeTitle];
    _imageArra = @[KHomeItemImage,KTeacherItemImage,KClassItemImage,KMeItemImage];
    _imageArraSel = @[KHomeItemImageSelected,KTeacherItemImageSelected,KClassItemImageSelected,KMeItemImageSelected];
    
    UITabBarItem *zhuye = self.tabBar.items[0];
    [self setBarWithBarItem:zhuye atindex:0];
    
    UITabBarItem *mingshi = self.tabBar.items[1];
    [self setBarWithBarItem:mingshi atindex:1];
    
    UITabBarItem *kejian = self.tabBar.items[2];
    [self setBarWithBarItem:kejian atindex:2];
    
    UITabBarItem *geren = self.tabBar.items[3];
    [self setBarWithBarItem:geren atindex:3];
    
    self.selectedIndex = 0;
}


-(void)setBarWithBarItem:(UITabBarItem *)item atindex:(NSInteger ) index
{
    
    UIImage *itemImage = [UIImage imageNamed:_imageArra[index]];
    
    UIImage *itemImageSel = [UIImage imageNamed:_imageArraSel[index]];
    
    itemImage = [itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    itemImageSel = [itemImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item = [[UITabBarItem alloc] initWithTitle:_nameArra[index] image:itemImage selectedImage:itemImageSel];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1.0]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:243.0/255.0 green:67.0/255.0 blue:59.0/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    
    NSArray *childs = [self childViewControllers];
    
    UIViewController *viewCon = [childs objectAtIndex:index];
    viewCon.tabBarItem = item;
    /*  bug 第二次代入时产生错误，Could not load NIB in bundle: 'NSBundle </Users/peter/Library/Developer/CoreSimulator/Devices/41E36C01-A38F-472B-9550-5598CCE47E4B/data/Containers/Bundle/Application/D3208855-AB0B-470C-95CB-0200A796C045/ZNTG客户端.app> (loaded)' with name 'c7X-it-4CU-view-p4s-bo-ekg'' */
    // self.selectedIndex = 0;
    NSLog(@"ffffff%@fff",item);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
