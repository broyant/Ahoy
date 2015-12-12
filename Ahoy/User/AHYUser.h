//
//  AHYUser.h
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHYUser : NSObject

@property (nonatomic, assign) long userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger unit;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic, strong) NSString *amazingThing;

@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSMutableArray *workExperiences;
@property (nonatomic, strong) NSMutableArray *educationArray;

@property (nonatomic, assign) CGFloat reviewRating;
@property (nonatomic, assign) BOOL isReviewed;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, strong) NSMutableArray *reviewArray;
@property (nonatomic, strong) NSMutableArray *reviewTags;

@property (nonatomic, strong) NSMutableArray *recommendedAdvisors;

@end
