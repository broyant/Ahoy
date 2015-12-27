//
//  Utility.h
//  Ahoy
//
//  Created by chunlian on 15/12/21.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (void)changeHeight:(UIView*)view height:(float)height;
+ (void)changeWidth:(UIView*)view width:(float)width;
+ (void)changeX:(UIView*)view x:(float)x;
+ (void)changeY:(UIView*)view y:(float)y;

@end
