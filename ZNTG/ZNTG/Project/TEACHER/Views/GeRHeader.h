//
//  GeRHeader.h
//  newproject
//
//  Created by Peter on 8/1/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeRHeader : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBTN;
@property (weak, nonatomic) IBOutlet UIButton *focusBTN;
@property (weak, nonatomic) IBOutlet UIButton *lookBTN;
+(instancetype)GeRHeader;

-(void)setWithName:(NSString *)name
             title:(NSString *)title
              corp:(NSString *)corp
         signature:(NSString *)sig
           jianJie:(NSString *)jianjie
              fans:(NSString *)fans
     purchaseCount:(NSString *)count;
@end
