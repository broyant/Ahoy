//
//  AHYTopicCategory.h
//  Ahoy
//
//  Created by lcj on 15/10/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "JSONModelLib.h"
#import "AHYTopic.h"

@interface AHYTopicCategory : JSONModel

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, strong) NSString <Optional> *cName;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Optional, AHYTopic> *topics;

@end
