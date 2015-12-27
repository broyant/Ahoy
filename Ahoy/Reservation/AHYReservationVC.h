//
//  AHYReservationVC.h
//  Ahoy
//
//  Created by chunlian on 15/12/13.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    createReservation = 0,
    modifyReservation,
} ReservationType;

@interface AHYReservationVC : UIViewController

@property (nonatomic, assign) ReservationType reservationType;

@end
