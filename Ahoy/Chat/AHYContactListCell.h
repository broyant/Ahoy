//
//  AHYContactListCell.h
//  TestLeanCloud
//
//  Created by broyant on 16/1/21.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import <SWTableViewCell/SWTableViewCell.h>
#import "OTRBuddy.h"

static CGFloat const kAHYContactListTableCellHeight = 90.f;
//#define kAHYContactListTableCellHeight 90.f
@interface AHYContactListCell : SWTableViewCell

@property (nonatomic,strong,readonly) OTRBuddy *buddy;

@property (nonatomic,strong,readonly) NSString *keyword;

- (void)configureWithOTRBuddy:(OTRBuddy *)buddy keyword:(NSString *)keyword;

+ (NSString *)reuseIdentifier;

@end
