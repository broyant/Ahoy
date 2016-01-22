//
//  JSQReserveView.h
//  JSQMessages
//
//  Created by broyant on 16/1/13.
//  Copyright © 2016年 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHYReserveView : UIView

//start Time,in seconds,actually should be NSTimeInterval
@property (nonatomic, strong) NSString *startTime;
//end Time,same above;
@property (nonatomic, strong) NSString *endTime;
//Topic to carry on;
@property (nonatomic, strong) NSString *topic;
//money have paid;
@property (nonatomic, assign) NSUInteger moneyPaid;
//note for reservation;
@property (nonatomic, strong) NSString *rsvNote;

- (void)configureWithStartTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                            topic:(NSString *)topic
                        moneyPaid:(NSUInteger)moneyPaid
                          rsvNote:(NSString *)rsvNote;

@end
