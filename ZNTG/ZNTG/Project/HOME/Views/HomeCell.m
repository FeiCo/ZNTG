//
//  HomeCell.m
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *transverseImgView;
@property (weak, nonatomic) IBOutlet UIImageView *triangleImgView;
@property (weak, nonatomic) IBOutlet UILabel *syLabel;
@property (weak, nonatomic) IBOutlet UILabel *zyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hyLabel;
@property (weak, nonatomic) IBOutlet UILabel *srdzLabel;
@property (weak, nonatomic) IBOutlet UIButton *telButton;

@property (nonatomic, strong) NSArray *contents;
@end

@implementation HomeCell

- (void)handleHomeCellWithName:(NSString *)name
                     buyAmount:(NSString *)buyAmount
                         price:(NSString *)price
                      contents:(NSArray *)contents {
    self.nameLabel.text = name;
    self.contents = contents;
    [self setupBuyTipsWithPrice:price buyAmount:buyAmount];
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
    CGRect triangleFrame = self.triangleImgView.frame;
    CGRect transverseFrame = self.transverseImgView.frame;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.transverseImgView.frame = CGRectMake(sender.left, transverseFrame.origin.y, transverseFrame.size.width, transverseFrame.size.height);
    }];
    self.triangleImgView.frame = CGRectMake((sender.centerX - (triangleFrame.size.width / 2)), triangleFrame.origin.y, triangleFrame.size.width, triangleFrame.size.height);
    
    if (sender.tag == 3) {
        _telButton.hidden = NO;
        _buyTipsLabel.hidden = YES;
        _buyButton.hidden = YES;
    }else {
        _telButton.hidden = YES;
        _buyTipsLabel.hidden = NO;
        _buyButton.hidden = NO;
    }
    
    self.contentLabel.text = [_contents objectAtIndex:sender.tag];
}

- (void)setupBuyTipsWithPrice:(NSString *)price buyAmount:(NSString *)buyAmount {
    NSString *buyTips = [NSString stringWithFormat:@"%@元已有%@人购买",price,buyAmount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:buyTips];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kCustomColor(238, 40, 70, 1) range:NSMakeRange(0, price.length + 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, price.length + 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kCustomColor(243, 144, 19, 1) range:NSMakeRange(price.length + 1 + 2, buyAmount.length)];
    self.buyTipsLabel.attributedText = attributedString;
}

@end
