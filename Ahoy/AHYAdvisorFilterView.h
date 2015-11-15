//
//  AHYAdvisorFilterView.h
//  Ahoy
//
//  Created by lichuanjun on 8/11/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHYAdvisorFilterView;

@protocol AHYAdvisorFilterViewDelegate <NSObject>

- (void)cancelButtonDidPressed:(AHYAdvisorFilterView *)filterView;

- (void)applyButtonDidPressed:(AHYAdvisorFilterView *)filterView;

@end

@interface AHYAdvisorFilterView : UIView

@property (nonatomic, weak) id<AHYAdvisorFilterViewDelegate>delegate;

+ (instancetype)filterView;

- (void)show;


@end
