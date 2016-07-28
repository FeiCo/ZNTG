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
    self.window.rootViewController = tabC;
    [self.window makeKeyAndVisible];
    return YES;
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
