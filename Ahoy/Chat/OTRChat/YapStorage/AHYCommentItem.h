//
//  AHYCommentItem.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/19.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "OTRMediaItem.h"

extern NSString *const AHYCommentType;

@interface AHYCommentItem : OTRMediaItem

@property (nonatomic,assign) NSUInteger rate;

@property (nonatomic,assign) NSInteger attitude;

@property (nonatomic,assign) NSInteger professional;

@property (nonatomic,assign) NSInteger punctual;

@property (nonatomic,strong) NSString *comment;

@end
