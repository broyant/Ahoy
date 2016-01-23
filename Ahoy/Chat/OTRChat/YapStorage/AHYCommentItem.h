//
//  AHYCommentItem.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "OTRMediaItem.h"

static NSString* const AHYCommentType = @"AHYComment";

@interface AHYCommentItem : OTRMediaItem
//rating,0 to 5;
@property (nonatomic,assign) NSUInteger rating;
//value,-1 or 0 or 1;
@property (nonatomic,assign) NSInteger value;
//communication,same above
@property (nonatomic,assign) NSInteger communication;
//same above
@property (nonatomic,assign) NSInteger friendliness;
//comment
@property (nonatomic,strong) NSString *comment;

@end
