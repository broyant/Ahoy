//
//  UIAdvisePageScrollView.h
//  Ahoy
//
//  Created by chunlian on 15/11/13.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CollectionNomalScroll = 0,
    CollectionPageScroll,
    CollectionSelectScroll,
} CollectionScrollType;

@protocol AdviseScrollViewDelegate <NSObject>

- (void)didSelectedItem:(NSInteger)row;

@end

@interface UIAdvisePageScrollView : UIView

@property (nonatomic, weak) id<AdviseScrollViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame scrollType:(NSUInteger)type;

@end
