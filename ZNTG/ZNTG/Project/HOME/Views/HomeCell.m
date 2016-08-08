//
//  HomeCell.m
//  ZNTG
//
//  Created by FeiCao on 16/7/28.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"

@interface HomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *newlyLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _newlyLabel.layer.cornerRadius = 3.0f;
    _newlyLabel.layer.masksToBounds = YES;
}

- (void)handleHomeCellWithPhotoURL:(NSURL *)url
                              name:(NSString *)name
                             price:(NSString *)price
                            buyNum:(NSString *)buyNum
                       mobilePhone:(NSString *)mobilePhone 
                      currentIndex:(NSInteger)index
                       description:(NSString *)descriptions
                        isSelected:(BOOL)isSelected {
    
    [self.photoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Default_Avatar1"]];
    self.nameLabel.text = name;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",price];
    _descriptionLabel.text = descriptions;
    
    if ([name isEqualToString:@"kkk"]) {
        _newlyLabel.hidden = NO;
    }else {
        _newlyLabel.hidden = YES;
    }
    
    if (isSelected == YES) {
        _descriptionLabel.hidden = NO;
    }else {
        _descriptionLabel.hidden = YES;
    }
    
    NSString *buyString = [NSString stringWithFormat:@"已有%@人购买",buyNum];
    NSMutableAttributedString *buyNumString = [[NSMutableAttributedString alloc] initWithString:buyString];
    [buyNumString addAttribute:NSForegroundColorAttributeName value:kCustomColor(240, 60, 60, 1) range:NSMakeRange(2, buyNum.length)];
    self.buyNumLabel.attributedText = buyNumString;
    
    if (index == 3) {
        [_buyButton setTitle:mobilePhone forState:UIControlStateNormal];
    }else {
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    }
}
@end
