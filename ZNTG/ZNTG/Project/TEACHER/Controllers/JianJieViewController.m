//
//  JianJieViewController.m
//  ZNTG
//
//  Created by Peter on 8/8/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "JianJieViewController.h"
#define PHTextFont [UIFont systemFontOfSize:17]
#define screenB  [UIScreen mainScreen].bounds

@interface JianJieViewController ()

@end

@implementation JianJieViewController


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简介";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO];
    self.jianJie = @"中华人名共和国，中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国中华人名共和国";
    CGSize textSize = [self sizeWithText:self.jianJie font:PHTextFont maxSize:CGSizeMake(screenB.size.width - 20, MAXFLOAT)];
    UILabel *jianJieL = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, screenB.size.width - 20, textSize.height)];
    jianJieL.font = PHTextFont;
    jianJieL.numberOfLines = 0;
    jianJieL.text = self.jianJie;
    [self.view addSubview:jianJieL];
    // Do any additional setup after loading the view.
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
