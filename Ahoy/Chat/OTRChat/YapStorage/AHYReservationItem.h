//
//  AHYReservationItem.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "OTRMediaItem.h"

extern NSString * const AHYReservationType;

@interface AHYReservationItem : OTRMediaItem

@property (nonatomic, strong) NSString *rsvDate;

@property (nonatomic, strong) NSString *rsvTime;

@property (nonatomic, strong) NSString *rsvNote;

@end
