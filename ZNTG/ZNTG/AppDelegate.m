//
//  AppDelegate.m
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#import "AppDelegate.h"
#import "TeacherViewController.h"
#import "GeRenTableViewController.h"
#import "HomeViewController.h"
#import "NaviViewController.h"
#import "MainTabViewController.h"

#import "ClassTableViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSArray * nameArra;
@property (nonatomic, strong) NSArray * imageArra;
@property (nonatomic, strong) NSArray * imageArraSel;

@property(nonatomic,weak)MainTabViewController *mainC;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//配置TabbarController
    HomeViewController *homeC = [[HomeViewController alloc] init];
    TeacherViewController *teacherC = [[TeacherViewController alloc] init];
    ClassTableViewController *classC = [[ClassTableViewController alloc] init];
    GeRenTableViewController *meC = [[GeRenTableViewController alloc] init];
    
    NaviViewController *navi1 = [[NaviViewController alloc] initWithRootViewController:homeC];
    NaviViewController *navi2 = [[NaviViewController alloc] initWithRootViewController:teacherC];
    NaviViewController *navi3 = [[NaviViewController alloc] initWithRootViewController:classC];
    NaviViewController *navi4 = [[NaviViewController alloc] initWithRootViewController:meC];
    
    NSArray *controllerarray = [[NSArray alloc] initWithObjects:navi1,navi2,navi3,navi4, nil];
    MainTabViewController *tabC = [[MainTabViewController alloc] init];
    tabC.viewControllers = controllerarray;
    tabC.selectedIndex = 0;
    _mainC = tabC;
    [self setTabBar];
    self.window.rootViewController = tabC;
    [self.window makeKeyAndVisible];
    return YES;
}




#pragma mark -- settingTabarItem


-(void)setTabBar{
    _nameArra = @[KHomeTitle,KTeacherTitle,KClassTitle,KMeTitle];
    _imageArra = @[KHomeItemImage,KTeacherItemImage,KClassItemImage,KMeItemImage];
    _imageArraSel = @[KHomeItemImageSelected,KTeacherItemImageSelected,KClassItemImageSelected,KMeItemImageSelected];
    
    UITabBarItem *zhuye = _mainC.tabBar.items[0];
    [self setBarWithBarItem:zhuye atindex:0];
    
    UITabBarItem *mingshi = _mainC.tabBar.items[1];
    [self setBarWithBarItem:mingshi atindex:1];
    
    UITabBarItem *kejian = _mainC.tabBar.items[2];
    [self setBarWithBarItem:kejian atindex:2];
    
    UITabBarItem *geren = _mainC.tabBar.items[3];
    [self setBarWithBarItem:geren atindex:3];
    
    _mainC.selectedIndex = 0;
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
    
    
    NSArray *childs = [_mainC childViewControllers];
    
    UIViewController *viewCon = [childs objectAtIndex:index];
    viewCon.tabBarItem = item;
    /*  bug 第二次代入时产生错误，Could not load NIB in bundle: 'NSBundle </Users/peter/Library/Developer/CoreSimulator/Devices/41E36C01-A38F-472B-9550-5598CCE47E4B/data/Containers/Bundle/Application/D3208855-AB0B-470C-95CB-0200A796C045/ZNTG客户端.app> (loaded)' with name 'c7X-it-4CU-view-p4s-bo-ekg'' */
    // self.selectedIndex = 0;
    NSLog(@"ffffff%@fff",item);
    
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
