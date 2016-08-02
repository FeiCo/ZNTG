//
//  TeacherCell.m
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "TeacherCell.h"
#import "UIImageView+WebCache.h"

@implementation TeacherCell

- (void)handleTeacherCellWithIcon:(NSString *)url
                             name:(NSString *)name
                       levelImage:(NSURL *)levelUrl
                       levelLabel:(NSString *)level
                        introduce:(NSString *)descriptions {

    self.nameLabel.text = name;
    self.levelLabel.text = level;
    self.introduceLabel.text = descriptions;
    NSURL *urlString = [NSURL URLWithString:url];
    [self.iconImageView sd_setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@""]];
}


@end
