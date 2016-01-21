//
//  JSQReserveView.h
//  JSQMessages
//
//  Created by broyant on 16/1/13.
//  Copyright © 2016年 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHYReserveView : UIView

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *note;

- (instancetype)initWithDate:(NSString *)date time:(NSString *)time note:(NSString *)note;

@end
