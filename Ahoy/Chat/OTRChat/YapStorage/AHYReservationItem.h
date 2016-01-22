//
//  AHYReservationItem.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "OTRMediaItem.h"

extern NSString *AHYReservationType;

@interface AHYReservationItem : OTRMediaItem

//start Time,in seconds,actually should be NSTimeInterval
@property (nonatomic, strong) NSString *startTime;
//end Time,same above;
@property (nonatomic, strong) NSString *endTime;
//Topic to carry on;
@property (nonatomic, strong) NSString *topic;
//money have payed;
@property (nonatomic, assign) NSUInteger moneyPaid;
//note for reservation;
@property (nonatomic, strong) NSString *rsvNote;

@end
