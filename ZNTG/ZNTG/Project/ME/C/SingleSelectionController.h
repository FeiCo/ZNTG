//
//  SingleSelectionController.h
//  ZNTG
//
//  Created by Peter on 8/10/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleSelectionController : UITableViewController


+(instancetype)singleSelectionWithDataArray:(NSArray *)arra intialValueIndex:(NSInteger)index andIdentifier:(NSString *)id;

@end
