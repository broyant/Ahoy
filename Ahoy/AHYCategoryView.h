//
//  AHYCategoryView.h
//  Ahoy
//
//  Created by lcj on 15/10/23.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHYCategoryView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)category
                       topics:(NSArray *)topicArray;

@end
