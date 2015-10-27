//
//  AHYRecommendTopic.h
//  Ahoy
//
//  Created by lcj on 15/10/24.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHYRecommendTopic : NSObject

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger advisors;
@property (nonatomic, assign) NSInteger sessions;

@end
