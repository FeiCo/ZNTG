//
//  HomeCell.m
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "HomeCell.h"
#import "Teachers.h"

@interface HomeCell()
@property (weak, nonatomic) IBOutlet UILabel *syLabel;
@property (weak, nonatomic) IBOutlet UILabel *zyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hyLabel;
@property (weak, nonatomic) IBOutlet UILabel *srdzLabel;
@property (weak, nonatomic) IBOutlet UIButton *telButton;
@property (weak, nonatomic) IBOutlet UIView *backgrandView;
@property (weak, nonatomic) IBOutlet UIButton *syButton;
@property (nonatomic, strong) UIImageView *transverseImage;
@property (nonatomic, strong) UIImageView *triangleImg;

@property (nonatomic, strong) Teachers *teachers;
@property (nonatomic, strong) NSArray *teacherArray;
@property (nonatomic, assign) NSInteger index;
@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _index = 0;
    
    _transverseImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, _syButton.bottom - kScreenHeightScale(4), _syButton.width, kScreenHeightScale(4))];
    _transverseImage.image = [UIImage imageNamed:@"transverse"];
    [self addSubview:_transverseImage];
    
    CGFloat triangleImgWidth = 18.f;
    CGFloat triangleImgHeight = 11.f;
    CGFloat triangleImgX = _syButton.centerX - (triangleImgWidth / 2);
    CGFloat triangleImgY = _backgrandView.top - triangleImgHeight + 1;

    _triangleImg = [[UIImageView alloc] initWithFrame:CGRectMake(triangleImgX, triangleImgY, triangleImgWidth, triangleImgHeight)];
    _triangleImg.image = [UIImage imageNamed:@"Home_Triangle"];
    [self addSubview:_triangleImg];
}

- (void)handleHomeCellFromTeachers:(NSArray *)teachers {
    self.teacherArray = teachers;
    self.teachers = [teachers objectAtIndex:_index];
    self.contentLabel.text = _teachers.descriptions;
    self.nameLabel.text = _teachers.teacherName;
    [self.telButton setTitle:_teachers.mobilePhone forState:UIControlStateNormal];
    [self setupBuyTipsWithPrice:_teachers.roomPrice buyAmount:_teachers.userNumber];
}

- (IBAction)changePlates:(UIButton *)sender {
    switch (sender.tag) {
        case 0:// 胜赢
            [self moveMarkerOfCurrentButton:sender];
            self.syLabel.textColor = kCustomColor(238, 40, 70, 1);
            self.zyLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.hyLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.srdzLabel.textColor = kCustomColor(76, 76, 76, 1);
            break;
        case 1:// 智赢
            [self moveMarkerOfCurrentButton:sender];
            self.zyLabel.textColor = kCustomColor(238, 40, 70, 1);
            self.syLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.hyLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.srdzLabel.textColor = kCustomColor(76, 76, 76, 1);
            break;
        case 2:// 慧赢
            [self moveMarkerOfCurrentButton:sender];
            self.hyLabel.textColor = kCustomColor(238, 40, 70, 1);
            self.syLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.zyLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.srdzLabel.textColor = kCustomColor(76, 76, 76, 1);
            break;
        case 3:// 私人订制
            [self moveMarkerOfCurrentButton:sender];
            self.srdzLabel.textColor = kCustomColor(238, 40, 70, 1);
            self.syLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.zyLabel.textColor = kCustomColor(76, 76, 76, 1);
            self.hyLabel.textColor = kCustomColor(76, 76, 76, 1);
            break;
    }
}

- (void)moveMarkerOfCurrentButton:(UIButton *)sender {
    _index = sender.tag;
    _teachers = [self.teacherArray objectAtIndex:_index];
    self.contentLabel.text = _teachers.descriptions;
    
    [self.telButton setTitle:_teachers.mobilePhone forState:UIControlStateNormal];
    [self setupBuyTipsWithPrice:_teachers.roomPrice buyAmount:_teachers.userNumber];
    
    CGRect triangleFrame = _triangleImg.frame;
    CGRect transverseFrame = _transverseImage.frame;
    CGRect oldFrame = sender.frame;
    
    [UIView animateWithDuration:0.2 animations:^{
        _transverseImage.frame = CGRectMake(oldFrame.origin.x, transverseFrame.origin.y, transverseFrame.size.width, transverseFrame.size.height);
    }];
    _triangleImg.frame = CGRectMake((sender.centerX - (triangleFrame.size.width / 2)), triangleFrame.origin.y, triangleFrame.size.width, triangleFrame.size.height);
    
    if (sender.tag == 3) {
        _telButton.hidden = NO;
        _buyTipsLabel.hidden = YES;
        _buyButton.hidden = YES;
    }else {
        _telButton.hidden = YES;
        _buyTipsLabel.hidden = NO;
        _buyButton.hidden = NO;
    }
}

- (void)setupBuyTipsWithPrice:(NSString *)price buyAmount:(NSString *)buyAmount {
    NSString *buyTips = [NSString stringWithFormat:@"%@元已有%@人购买",price,buyAmount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:buyTips];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kCustomColor(238, 40, 70, 1) range:NSMakeRange(0, 4)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kCustomColor(243, 144, 19, 1) range:NSMakeRange(6, 1)];
    self.buyTipsLabel.attributedText = attributedString;
}

@end
