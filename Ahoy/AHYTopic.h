//
//  AHYTopic.h
//  Ahoy
//
//  Created by lcj on 15/10/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHYTopicCategory.h"
@class AHYAdvisor;

@interface AHYTopic : NSObject

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *advisorListUrl; //get advisors when push into advisor list
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger totalAdvisors;
@property (nonatomic, assign) NSUInteger totalSessions;
@property (nonatomic, assign) TopicCategory category;
@property (nonatomic, assign) BOOL isRecommended;
@property (nonatomic, strong) NSArray *advisors;

@end

