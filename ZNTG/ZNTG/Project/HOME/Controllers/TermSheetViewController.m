//
//  TermSheetViewController.m
//  ZNTG
//
//  Created by FeiCao on 16/7/29.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "TermSheetViewController.h"

@interface TermSheetViewController ()

@end

@implementation TermSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeNavigation];
}

- (void)initializeNavigation {
    self.title = @"客户风险协议";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
