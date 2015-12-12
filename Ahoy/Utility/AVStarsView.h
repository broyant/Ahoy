//
//  AVStarsView.h
//  StarRatingDemo
//
//  Created by Jeff Hodnett on 5/8/14.
//  Copyright (c) 2014 Avira Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVStarsView;

@protocol AVStarsViewDelegate <NSObject>

- (void)starsViewRatingChanged:(AVStarsView *)starsView;

@end

@interface AVStarsView : UIView

@property(nonatomic ,weak) id<AVStarsViewDelegate>delegate;
@property(nonatomic) NSInteger count;
@property(nonatomic) CGFloat rating;

@property(nonatomic, copy) UIColor *onColor;
@property(nonatomic, copy) UIColor *offColor;

@property(nonatomic) CGFloat animationDuration;

-(void)setOn:(BOOL)state;
-(void)animate;

@end


@interface AVStarView : UIView

@property(nonatomic, copy) UIColor *onColor;
@property(nonatomic, copy) UIColor *offColor;
@property(nonatomic) BOOL isHalf;
@property(nonatomic) CGFloat animationDuration;
@property(nonatomic, readonly) BOOL isOn;

-(void)setOn:(BOOL)state;
-(void)setOn:(BOOL)state animated:(BOOL)animated;
-(void)setOn:(BOOL)state animated:(BOOL)animated complete:(void (^)(void))complete;

@end
