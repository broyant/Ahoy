//
//  AHYAdvisor.h
//  Ahoy
//
//  Created by lcj on 15/10/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "JSONModelLib.h"

@interface AHYAdvisor : JSONModel

@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, strong) NSString *portraitUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat reviewRate;

@end
