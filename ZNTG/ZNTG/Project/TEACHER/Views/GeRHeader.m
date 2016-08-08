//
//  GeRHeader.m
//  newproject
//
//  Created by Peter on 8/1/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "GeRHeader.h"

@interface GeRHeader()

@property(weak,nonatomic)UIView *headerV;

@property (weak, nonatomic) IBOutlet UILabel *corpL;
@property (weak, nonatomic) IBOutlet UILabel *jinPaiTG;
@property (weak, nonatomic) IBOutlet UILabel *zzzc;
@property (weak, nonatomic) IBOutlet UILabel *fansL;
@property (weak, nonatomic) IBOutlet UILabel *purchaseL;
@property (weak, nonatomic) IBOutlet UILabel *sigL;
@property (weak, nonatomic) IBOutlet UILabel *jianJieL;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *corp;
@property(nonatomic,copy)NSString *purchasecount;
@property(nonatomic,copy)NSString *sig;
@property(nonatomic,copy)NSString *jianJie;
@property(nonatomic,copy)NSString *fans;

@end
@implementation GeRHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)setWithName:(NSString *)name
             title:(NSString *)title
              corp:(NSString *)corp
         signature:(NSString *)sig
           jianJie:(NSString *)jianjie
              fans:(NSString *)fans
     purchaseCount:(NSString *)count {
    _name = name;
    _title = title;
    _corp = corp;
    _sig = sig;
    _jianJie = jianjie;
    _purchasecount = count;
    _fans = fans;
}



+(instancetype)GeRHeader{
    
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"GeRHeader" owner:self options:nil];
  return   [objects lastObject];
}


-(void)layoutSubviews {
    self.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 210);
      _zzzc.text = _name;
    _jinPaiTG.text = _title;
    _corpL.text = _corp;
    _jianJieL.text = _jianJie;
    _fansL.text = _fans;
    _purchaseL.text = _purchasecount;
    _sigL.text = _sig;
    _focusBTN.layer.cornerRadius = 14;
    _focusBTN.layer.borderWidth = 1;
    _focusBTN.layer.borderColor = [UIColor whiteColor].CGColor;
    
}


@end
