//
//  UIImage+SuoFang.m
//  imagepickerTEST
//
//  Created by Peter on 4/25/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "UIImage+SuoFang.h"

@implementation UIImage (SuoFang)


+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

@end
