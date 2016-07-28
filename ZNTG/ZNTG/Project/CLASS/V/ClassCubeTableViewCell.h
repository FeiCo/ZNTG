//
//  ClassCubeTableViewCell.h
//  ZNTG客户端
//
//  Created by Peter on 5/27/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ClassCubeImageClickdelegate <NSObject>

-(void)clickButtonArray:(NSArray *)array;

@end

@interface ClassCubeTableViewCell : UITableViewCell


@property (nonatomic,strong) NSDictionary *dataarrayLeft;
@property (nonatomic,strong) NSDictionary *dataarrayRight;

@property (nonatomic, weak) id<ClassCubeImageClickdelegate> delegate;
+(instancetype)ClassCubeWithTableView:(UITableView *)tableView;

@end
