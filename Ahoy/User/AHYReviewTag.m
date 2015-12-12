//
//  AHYReviewTag.m
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYReviewTag.h"

@implementation AHYReviewTag

- (void)parse:(NSDictionary *)dict
{
    self.tagId = [[dict objectForKey:@"tagId"] integerValue];
    self.tagName = [dict objectForKey:@"tagName"];
    self.isHighlight = [[dict objectForKey:@"isHighlight"] boolValue];
    self.count = [[dict objectForKey:@"numberOfReviews"] integerValue];
}

@end
