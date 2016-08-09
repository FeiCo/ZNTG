//
//  ClassCubeTableViewCell.m
//  ZNTG客户端
//
//  Created by Peter on 5/27/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "ClassCubeTableViewCell.h"
#import "UIImage+PHTintColor.h"
#import "UIImageView+WebCache.h"


#define screenB [UIScreen mainScreen].bounds
#define color(r,g,b,a)   [UIColor colorWithRed: ( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:( a / 1.0)]


@interface ClassCubeTableViewCell()

@property(nonatomic,weak) UIView *kuang1;
@property(nonatomic,weak) UIView *kuang2;

@property(nonatomic,weak) UIImageView *imageV1;
@property(nonatomic,weak) UIImageView *imageV2;

@property(nonatomic,weak) UIImageView *play1;
@property(nonatomic,weak) UIImageView *play2;

@property(nonatomic,weak) UILabel *title1;
@property(nonatomic,weak) UILabel *title2;

@property(nonatomic,weak) UILabel *yueDuLiang1;
@property(nonatomic,weak) UILabel *yueDuLiang2;


@end




@implementation ClassCubeTableViewCell


//-(void)setFrame:(CGRect)frame {
//    
//    CGRect tempt = frame;
//    tempt.origin.x += 10;
//    tempt.size.width -= 20;
//    [super setFrame:tempt];
//}

+(instancetype)ClassCubeWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"YanHuangZNTG";
    ClassCubeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ClassCubeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView* imageV1 =[[UIImageView alloc]init];
        UIImageView* imageV2 =[[UIImageView alloc]init];
        UILabel *title1 =[[UILabel alloc]init];
        UILabel *title2 =[[UILabel alloc]init];
        UIView *kaung1 =[[UIView alloc]init];
        UIView *kaung2 =[[UIView alloc]init];
        UILabel *yueDuLiang1 =[[UILabel alloc]initWithFrame:CGRectMake((screenB.size.width - 20 - 10) / 2 - 30, 85, 30, 10)];
        UILabel *yueDuLiang2 =[[UILabel alloc]initWithFrame:CGRectMake((screenB.size.width - 20 - 10) / 2 - 30, 85, 30, 10)];
        yueDuLiang1.text = @"23232";
        yueDuLiang2.text = @"232";
        yueDuLiang1.textColor = [UIColor whiteColor];
        yueDuLiang2.textColor = [UIColor whiteColor];
        yueDuLiang1.font = [UIFont systemFontOfSize:8];
        yueDuLiang2.font = [UIFont systemFontOfSize:8];
        
        
        
        UIView *xvXian1 =[[UIView alloc]initWithFrame:CGRectMake(0, 139, (screenB.size.width - 20 - 10) / 2, 1)];
        UIView *xvXian2 =[[UIView alloc]initWithFrame:CGRectMake(0, 139, (screenB.size.width - 20 - 10) / 2, 1)];
        xvXian1.backgroundColor = color(225, 225, 225, 1);
        xvXian2.backgroundColor = color(225, 225, 225, 1);
        kaung1.backgroundColor= [UIColor whiteColor];
        kaung2.backgroundColor= [UIColor whiteColor];
        
        
        title1.numberOfLines = 2;
        title2.numberOfLines = 2;
        
        
        [self.contentView addSubview:kaung1];
        [self.contentView addSubview:kaung2];

        
        _imageV1 = imageV1;
        _imageV2 = imageV2;
        _kuang1 = kaung1;
        _kuang2 = kaung2;
        _title1 = title1;
        _title2 = title2;
        
        _yueDuLiang1 = yueDuLiang1;
        _yueDuLiang2 = yueDuLiang2;
        _imageV1.tag = 1;
        _imageV2.tag = 2;

        imageV1.userInteractionEnabled = YES;
        imageV2.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *pic1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image1Click:)];
        pic1.numberOfTapsRequired = 1;
        UITapGestureRecognizer *pic2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image2Click:)];
        pic2.numberOfTapsRequired = 1;
        
        [imageV1 addGestureRecognizer:pic1];
        [imageV2 addGestureRecognizer:pic2];
        
        [self.kuang1 addSubview:xvXian1];
        [self.kuang2 addSubview:xvXian2];
        [self.kuang1 addSubview:imageV1];
        [self.kuang2 addSubview:imageV2];
        [self.kuang1 addSubview:yueDuLiang1];
        [self.kuang2 addSubview:yueDuLiang2];

        [self.kuang1 addSubview:title1];
        [self.kuang2 addSubview:title2];

        UIImageView *play1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KeJianplay"]];
        [_imageV1 addSubview:play1];
        _play1 = play1;
        UIImageView *play2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KeJianplay"]];
        [_imageV2 addSubview:play2];
        _play2 = play2;
    }
    return self;
}


-(void)image1Click:(id)sender {


        if ([self.delegate respondsToSelector:@selector(clickButtonArray:)]) {
            
            [self.delegate clickButtonArray:[_dataarrayLeft copy]];
            
        }
        NSLog(@"cellimage1");


}


-(void)image2Click:(id)sender {

        if ([self.delegate respondsToSelector:@selector(clickButtonArray:)]) {
            
            [self.delegate clickButtonArray:[_dataarrayRight copy]];
            
        }
        NSLog(@"cellimage2");
    
}



#pragma mark - settingarray

-(void)setDataarrayLeft:(NSArray *)dataarrayLeft {

    _dataarrayLeft = dataarrayLeft;
    
    [self settingData1];
    [self settingFrame1];
}


-(void)setDataarrayRight:(NSArray *)dataarrayRight {
    
    _dataarrayRight = dataarrayRight;
    
    [self settingData2];
    [self settingFrame2];
    
}


#pragma mark - settingdata and frame

-(void) settingData1 {


    NSString *urlstring = [_dataarrayLeft valueForKey:@"coverpageLocation"];
    [_imageV1 sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"default"]];
       _title1.text = [_dataarrayLeft valueForKey:@"description"];
    _title1.font = [UIFont systemFontOfSize:14];

//    _kuang1.layer.borderWidth = 0.5;
//    _kuang1.layer.borderColor = color(39, 141, 205, 1).CGColor;
    
}


-(void) settingFrame1 {
    
    CGFloat kuangW =  (screenB.size.width - 20 - 10) / 2;
    
    _kuang1.frame = CGRectMake(10, 10, kuangW, 140);

    _imageV1.frame = CGRectMake(0, 0, kuangW, 100);
    

    _play1.bounds = CGRectMake(0, 0, 30, 30);
    _play1.center = CGPointMake(kuangW / 2, 50);
    
    _title1.frame = CGRectMake(10, 95, kuangW - 10 , 50);
    _title1.textAlignment = NSTextAlignmentLeft;
    _title1.textColor = [UIColor blackColor];
    


}


-(void) settingData2 {
    
    if(!_dataarrayRight){
        _kuang2.hidden = YES;
    }
    else
    {
        _kuang2.hidden = NO;
    }
    NSString *urlstring = [_dataarrayRight valueForKey:@"coverpageLocation"];
    [_imageV2 sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"default"]];
    _title2.text = [_dataarrayRight valueForKey:@"description"];
    _title2.font = [UIFont systemFontOfSize:14];
    
//    _kuang2.layer.borderWidth = 0.5;
//    _kuang2.layer.borderColor = color(39, 141, 205, 1).CGColor;
    
}


-(void) settingFrame2 {
    
    CGFloat kuangW =  (screenB.size.width - 20 - 10) / 2;
    
    _kuang2.frame = CGRectMake(20 + kuangW, 10, kuangW, 140);
    
    _imageV2.frame = CGRectMake(0, 0, kuangW, 100);
    
    _play2.bounds = CGRectMake(0, 0, 30, 30);
    _play2.center = CGPointMake(kuangW / 2, 50);
    
    _title2.frame = CGRectMake(10, 95, kuangW - 10 , 50);
    _title2.textAlignment = NSTextAlignmentLeft;
    _title2.textColor = [UIColor blackColor];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
