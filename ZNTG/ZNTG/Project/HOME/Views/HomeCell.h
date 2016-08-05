//
//  HomeCell.h
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeCell : UITableViewCell

- (void)handleHomeCellWithPhotoURL:(NSURL *)url
                              name:(NSString *)name
                             price:(NSString *)price
                            buyNum:(NSString *)buyNum;
@end
