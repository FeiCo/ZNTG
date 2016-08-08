//
//  HomeCell.h
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface HomeCell : UITableViewCell
/** 查看 */
@property (weak, nonatomic) IBOutlet UIButton *seeaboutButton;

- (void)handleHomeCellWithPhotoURL:(NSURL *)url
                              name:(NSString *)name
                             price:(NSString *)price
                            buyNum:(NSString *)buyNum
                       mobilePhone:(NSString *)mobilePhone
                      currentIndex:(NSInteger)index
                       description:(NSString *)descriptions
                        isSelected:(BOOL)isSelected;

@end
