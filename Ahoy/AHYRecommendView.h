//
//  AHYRecommendView.h
//  Ahoy
//
//  Created by lcj on 15/10/22.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHYTopic.h"

@protocol AHYRecommendViewDelegate <NSObject>

- (void)recommendTopicDidSelected: (AHYTopic *)topic;

@end

@interface AHYRecommendView : UIView

@property (nonatomic, weak) id<AHYRecommendViewDelegate>delegate;

- (void)configure: (AHYTopic *)topic;

@end
