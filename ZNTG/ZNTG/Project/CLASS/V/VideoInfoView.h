//
//  VideoInfoView.h
//  ZNTG
//
//  Created by FeiCao on 16/8/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoInfoView : UIView

/** 老师头像 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 老师姓名 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 老师职位 */
@property (nonatomic, strong) UILabel *positionLabel;
/** 已观看数 */
@property (nonatomic, strong) UILabel *watchNumberLabel;
/** 点赞数 */
@property (nonatomic, strong) UIButton *thumbNumberButton;
/** 主题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 播出时间 */
@property (nonatomic, strong) UILabel *timeLabel;

@end
