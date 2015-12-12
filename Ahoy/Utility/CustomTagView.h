//
//  CustomTagView.h
//  Ahoy
//
//  Created by chunlian on 15/11/27.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTagView : UIView
{
    CGSize sizeFit;
}

@property (nonatomic, strong) NSMutableArray *tagArray;

- (void)setTags:(NSMutableArray *)array;
- (CGSize)fittedSize;

@end
