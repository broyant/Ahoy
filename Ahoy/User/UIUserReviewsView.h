//
//  UIUserReviewsView.h
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHYUser.h"

@interface UIUserReviewsView : UIView

@property(nonatomic, strong) AHYUser  *userMsg;

- (CGFloat)getheight;

@end