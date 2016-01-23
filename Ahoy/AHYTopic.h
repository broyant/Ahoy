//
//  AHYTopic.h
//  Ahoy
//
//  Created by lcj on 15/10/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "JSONModelLib.h"
@class AHYAdvisor;

@protocol AHYTopic <NSObject>

@end

@interface AHYTopic : JSONModel

@property (nonatomic, assign) NSInteger tid;
@property (nonatomic, strong) NSString<Optional> *thumbnailUrl;
@property (nonatomic, strong) NSString<Optional> *tName;

@end

