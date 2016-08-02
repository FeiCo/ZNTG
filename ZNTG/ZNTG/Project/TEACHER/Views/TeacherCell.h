//
//  TeacherCell.h
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

- (void)handleTeacherCellWithIcon:(NSString *)url
                             name:(NSString *)name
                       levelImage:(NSURL *)levelUrl
                       levelLabel:(NSString *)level
                        introduce:(NSString *)descriptions;

@end
