//
//  AHYCategoryView.h
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHYTopic;

@protocol AHYCategoryViewDelegate <NSObject>

- (void)topicDidSelected:(AHYTopic *)topic;

@end

@interface AHYCategoryView : UIView

@property (nonatomic, weak) id<AHYCategoryViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)category
                       topics:(NSArray *)topicArray;

@end
