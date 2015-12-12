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
} CollectionScrollType;

@interface UIAdvisePageScrollView : UIView

- (id)initWithFrame:(CGRect)frame scrollType:(NSUInteger)type;

@end
