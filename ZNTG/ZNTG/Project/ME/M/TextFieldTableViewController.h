//
//  TextFieldTableViewController.h
//  testtest
//
//  Created by Peter Hu on 16/7/29.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextTableViewStyle) {
    TextTableViewStyleField =1,          // TextField
    TextTableViewStyleView,         // TextView
};

typedef NS_ENUM(NSInteger, TextTableViewKeyBoardType) {
    TextTableViewKeyBoardTypeNumber =1,          // TextField
    TextTableViewKeyBoardTypeNormal,         // TextView
};


@interface TextFieldTableController : UITableViewController


+(instancetype)TextFieldControllerWithType:(TextTableViewStyle)style
                               defaultText:(NSString *)str
                              keyBoardType:(TextTableViewKeyBoardType)type
                              andWordLimit:(NSInteger)count;

@end
