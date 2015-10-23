//
//  AVStarsView.m
//  StarRatingDemo
//
//  Created by Jeff Hodnett on 5/8/14.
//  Copyright (c) 2014 Avira Inc. All rights reserved.
//

#import "AVStarsView.h"

// Defaults
NSInteger const kDefaultStarsCount =                5;
NSInteger const kDefaultStarsRating =               0;
NSInteger const kStarNoSides =                      5;
CGFloat const kStarDefaultAnimationDuration =       0.3f;
#define kStarDefaultOnColor                         [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:0 alpha:1.0f]
#define kStarDefaultOffColor                        [UIColor blackColor]

// --------------------------------------------
//              AVStarsView
// --------------------------------------------
@interface AVStarsView()
{
    NSInteger _animationIndex;
}

@property(nonatomic, strong) NSMutableArray *stars;

@end

@implementation AVStarsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.count = kDefaultStarsCount;
        self.rating = kDefaultStarsRating;
        self.stars = [NSMutableArray arrayWithCapacity:self.count];
        _onColor = kStarDefaultOnColor;
        _offColor = kStarDefaultOffColor;
        _animationDuration = self.count * kStarDefaultAnimationDuration;
        
        // Create stars
        [self _create];
    }
    return self;
}

-(void)_create
{
    // Remove old
    for (AVStarView *star in self.stars) {
        [star removeFromSuperview];
    }
    [self.stars removeAllObjects];
    
    // Check count
    if (self.count <= 0) {
        return;
    }
    
    // In with the new
    CGRect f = self.bounds;
    CGSize s = CGSizeMake(f.size.width / self.count, f.size.height);
    CGFloat x = 0;
    CGFloat y = (f.size.height - s.height)/2;
    for (int i = 0; i < self.count; i++) {
        CGRect f = CGRectMake(x, y, s.width, s.height);
        AVStarView *star = [[AVStarView alloc] initWithFrame:f];
        star.onColor = self.onColor;
        star.offColor = self.offColor;
        [star setOn:NO];
        
        [self addSubview:star];
        [self.stars addObject:star];
        
        x += s.width;
    }
}

-(void)setCount:(NSInteger)count
{
    _count = count;
    [self _create];
}

-(void)setRating:(CGFloat)rating
{
    _rating = rating;
    int i = 0;
    CGFloat mod = fmodf(self.rating, 1.0f);
    for (AVStarView *star in self.stars) {
        if(mod == 0.5f && i == floorf(self.rating)) {
            star.isHalf = YES;
        }
        [star setOn:(i < self.rating)];
        i++;
    }
}

-(void)setAnimationDuration:(CGFloat)animationDuration
{
    _animationDuration = animationDuration;
    CGFloat starDuration = _animationDuration / self.count;
    for (AVStarView *star in self.stars) {
        star.animationDuration = starDuration;
    }
}

-(void)setOn:(BOOL)state
{
    // Disable all
    for (AVStarView *star in self.stars) {
        [star setOn:state];
    }
}

-(void)animate
{
    // Disable all
    [self setOn:NO];
    
    // Start our animation
    _animationIndex = 0;
    [self _animate];
}

-(void)_animate
{
    if(_animationIndex < [self.stars count] && _animationIndex < self.rating) {
        AVStarView *star = [self.stars objectAtIndex:_animationIndex];
        [star setOn:YES animated:YES complete:^{
            _animationIndex++;
            [self _animate];
        }];

    }
}

@end

// --------------------------------------------
//              AVStarView
// --------------------------------------------
@interface AVStarView()

@property(nonatomic, strong) CAShapeLayer *onStarLayer;
@property(nonatomic, strong) CAShapeLayer *offStarLayer;

@property(nonatomic, readwrite) BOOL isOn;
@property (nonatomic, copy) void (^complete)(void);

@end

@implementation AVStarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        _animationDuration = kStarDefaultAnimationDuration;
        _isHalf = NO;
        _onColor = kStarDefaultOnColor;
        _offColor = kStarDefaultOffColor;
        
        self.isOn = YES;
        
        // Create the star path
        CGRect f = self.bounds;
        CGPathRef starPath = [self createStarPathInRect:f];
        
        // Off star layer
        self.offStarLayer = [CAShapeLayer layer];
        self.offStarLayer.frame = f;
        self.offStarLayer.path = starPath;
        self.offStarLayer.fillColor = self.offColor.CGColor;
        [self.layer addSublayer:self.offStarLayer];
        
        // On star layer
        self.onStarLayer = [CAShapeLayer layer];
        self.onStarLayer.frame = f;
        self.onStarLayer.path = starPath;
        self.onStarLayer.fillColor = self.onColor.CGColor;
        [self.layer addSublayer:self.onStarLayer];
        
        CGPathRelease(starPath);
        
        // Add mask
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.frame = f;
        self.onStarLayer.mask = mask;
        [self _updateMaskPath];
    }
    return self;
}

-(void)setOn:(BOOL)state
{
    [self setOn:state animated:NO complete:nil];
}

-(void)setOn:(BOOL)state animated:(BOOL)animated
{
    [self setOn:state animated:animated complete:nil];
}

-(void)setOn:(BOOL)state animated:(BOOL)animated complete:(void (^)(void))complete
{
    if(!animated) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self.onStarLayer setHidden:!state];
        [CATransaction commit];
    }
    else {
        // Store callback block
        self.complete = complete;
        
        // Grab mask layer
        CAShapeLayer *maskLayer = (CAShapeLayer *)self.onStarLayer.mask;
        CGRect f = maskLayer.frame;
        
        [self.onStarLayer setHidden:!state];

        // Animate
        CABasicAnimation *animation = [CABasicAnimation animation];
        [animation setValue:@"pathAnimation" forKey:@"id"];
        CGPathRef toPath = maskLayer.path;
        CGMutablePathRef fromPath = CGPathCreateMutable();
        CGPathAddRect(fromPath, NULL, CGRectMake(0, 0, 0, f.size.height));
        animation.fromValue = (__bridge id)fromPath;
        CGPathRelease(fromPath);
        animation.toValue = (__bridge id)toPath;
        animation.removedOnCompletion = FALSE;
        animation.duration = self.animationDuration;
        animation.delegate = self;
        [maskLayer addAnimation:animation forKey:@"path"];
    }

    self.isOn = state;
}

-(void)setIsHalf:(BOOL)isHalf
{
    _isHalf = isHalf;
    [self _updateMaskPath];
}

-(void)_updateMaskPath
{
    CGRect f = self.bounds;
    CAShapeLayer *mask = (CAShapeLayer *)self.onStarLayer.mask;
    CGMutablePathRef maskPath = CGPathCreateMutable();
    if(self.isHalf) {
        CGPathAddRect(maskPath, NULL, CGRectMake(0, 0, f.size.width/2, f.size.height));
    }
    else {
        CGPathAddRect(maskPath, NULL, f);
    }
    mask.path = maskPath;
    CGPathRelease(maskPath);
}

-(void)setOnColor:(UIColor *)onColor
{
    _onColor = onColor;
    self.onStarLayer.fillColor = _onColor.CGColor;
}

-(void)setOffColor:(UIColor *)offColor
{
    _offColor = offColor;
    self.offStarLayer.fillColor = _offColor.CGColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // Update paths
    CGRect f = self.bounds;
    CGPathRef starPath = [self createStarPathInRect:f];
    self.offStarLayer.path = starPath;
    self.onStarLayer.path = starPath;
    CGPathRelease(starPath);
    
    // Update frames
    self.offStarLayer.frame = f;
    self.onStarLayer.frame = f;
    CALayer *mask = self.onStarLayer.mask;
    mask.frame = f;
}

-(CGPathRef)createStarPathInRect:(CGRect)rect
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat xCenter = (rect.size.width / 2);
    CGFloat yCenter = (rect.size.height / 2);
    CGFloat width = (rect.size.width > rect.size.height) ? rect.size.height : rect.size.width;
    double r = width / 2.0;
    CGFloat flip = -1.0;
    double theta = 2.0 * M_PI * (2.0 / 5.0);
    CGPathMoveToPoint(path, NULL, xCenter, r*flip+yCenter);
    for(NSUInteger k=1; k < kStarNoSides; k++) {
        CGFloat x = r * sin(k * theta);
        CGFloat y = r * cos(k * theta);
        CGPathAddLineToPoint(path, NULL, x+xCenter, y*flip+yCenter);
    }
    CGPathCloseSubpath(path);
    
    return path;
}

#pragma mark - Animation delegate
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    if([[animation valueForKey:@"id"] isEqual:@"pathAnimation"]) {
        if(self.complete) {
            self.complete();
        }
    }
}

@end
