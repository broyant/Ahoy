//
//  AHYUser.m
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYUser.h"
#import "AHYReviewTag.h"

@implementation AHYUser

- (void)parse:(NSDictionary *)dict
{
    self.userId = [[dict objectForKey:@"userId"] longValue];
    self.userName = [dict objectForKey:@"userName"];
    self.title = [dict objectForKey:@"title"];
    self.thumbnailUrl = [dict objectForKey:@"thumbnailUrl"];
    self.amazingThing = [dict objectForKey:@"amazingThing"];
    self.userName = [dict objectForKey:@"userName"];

    NSDictionary *reviewSection = [dict objectForKey:@"reviewSection"];
    if (reviewSection.count > 0) {
        self.reviewRating = [[reviewSection objectForKey:@"rating"] floatValue];
        self.isReviewed = [[reviewSection objectForKey:@"isReviewed"] boolValue];
        self.reviewCount = [[reviewSection objectForKey:@"numberOfReviews"] integerValue];
        
        self.reviewTags = [[NSMutableArray alloc] initWithCapacity:0];
        NSArray *tags = [dict objectForKey:@"tags"];
        for (NSDictionary *tag in tags) {
            AHYReviewTag *reviewTag = [[AHYReviewTag alloc] init];
            [reviewTag parse:tag];
            [self.reviewTags addObject:reviewTag];
        }
    }

}


@end
