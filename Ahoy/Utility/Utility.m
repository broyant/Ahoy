//
//  Utility.m
//  Ahoy
//
//  Created by chunlian on 15/12/21.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (void)changeHeight:(UIView*)view height:(float)height
{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}

+ (void)changeWidth:(UIView*)view width:(float)width
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

+ (void)changeX:(UIView*)view x:(float)x
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

+ (void)changeY:(UIView*)view y:(float)y
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

@end
