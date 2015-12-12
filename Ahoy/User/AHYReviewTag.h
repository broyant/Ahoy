//
//  AHYReviewTag.h
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHYReviewTag : NSObject

@property (nonatomic, assign) NSInteger  tagId;
@property (nonatomic, strong) NSString  *tagName;
@property (nonatomic, assign) BOOL  isHighlight;
@property (nonatomic, assign) NSInteger  count;

- (void)parse:(NSDictionary *)dict;

@end
