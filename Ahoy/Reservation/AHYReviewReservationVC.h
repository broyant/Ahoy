//
//  AHYReviewReservationVC.h
//  Ahoy
//
//  Created by chunlian on 15/12/25.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHYReviewReservationVC : UIViewController

@property (nonatomic, strong)  NSDate *startDate;
@property (nonatomic, strong)  NSDate *endDate;
@property (nonatomic, assign)  float payMoney;
@property (nonatomic, strong)  NSString *callTips;

@end
