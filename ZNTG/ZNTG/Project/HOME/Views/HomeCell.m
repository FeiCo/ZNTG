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
@property (weak, nonatomic) IBOutlet UIButton *seeaboutButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
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
                            buyNum:(NSString *)buyNum {
    [self.photoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Default_Avatar1"]];
    self.nameLabel.text = name;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",price];
//    self.buyNumLabel.text =
    NSString *buyString = [NSString stringWithFormat:@"已有%@购买",buyNum];
    
    NSAttributedString *buyNumString = [[NSAttributedString alloc] initWithString:buyString];
//    buyNumString attribute:@{ } atIndex:<#(NSUInteger)#>
}

@end
