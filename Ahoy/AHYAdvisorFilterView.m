//
//  AHYAdvisorFilterView.m
//  Ahoy
//
//  Created by lichuanjun on 8/11/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import "AHYAdvisorFilterView.h"
#import "RFSegmentView.h"
#import "NMRangeSlider.h"
#import "AVStarsView.h"
#import "UIColor+Hex.h"
#import "UIImage+Color.h"

@interface AHYAdvisorFilterView ()<RFSegmentViewDelegate, AVStarsViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet RFSegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UILabel *lowerPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *upperPriceLabel;
@property (weak, nonatomic) IBOutlet NMRangeSlider *slider;
@property (weak, nonatomic) IBOutlet AVStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *filterTypeLabels;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation AHYAdvisorFilterView

- (void)awakeFromNib {
    [self configureSubviews];
    self.frame = [[UIScreen mainScreen] bounds];
}

+ (instancetype)filterView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
}

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [UIView animateWithDuration:0.2 animations:^{
        [keyWindow addSubview:self];
    }];
}

- (void)hidden {
   [UIView animateWithDuration:0.2 animations:^{
       [self removeFromSuperview];
   }];
}

#pragma mark --configureSubviews

- (void)configureSubviews {
    [self configureLabelAndButton];
    [self configureSegmentView];
    [self configureSlider];
    [self configureStarsView];
}

- (void)configureLabelAndButton {
    [_resetButton setTitleColor:AHYGrey40 forState:UIControlStateNormal];
    [_applyButton setTitleColor:AHYGrey40 forState:UIControlStateNormal];
    [_cancelButton setTitleColor:AHYBlue forState:UIControlStateNormal];
    for (UIButton *button in _buttons) {
        button.titleLabel.font = TradeGothicLT(18);
    }
    
    for (UILabel *filterType in _filterTypeLabels) {
        filterType.textColor = AHYGrey40;
        filterType.font = TradeGothicLTBoldTwo(14);
    }
    _starsLabel.textColor = AHYYellow;
    _lowerPriceLabel.textColor = AHYYellow;
    _upperPriceLabel.textColor = AHYYellow;
    _starsLabel.font = TradeGothicLT(16);
    _lowerPriceLabel.font = TradeGothicLT(16);
    _upperPriceLabel.font = TradeGothicLT(16);
}

- (void)configureSegmentView {
    NSArray *items = @[@"Popularity", @"Hourly Rate", @"Review"];
    [_segmentView setupWithItems:items];
    _segmentView.delegate = self;
    _segmentView.tintColor = AHYBlue;
}

- (void)configureSlider {
    _slider.minimumValue = 0;
    _slider.maximumValue = 500;
    _slider.lowerValue = 0;
    _slider.upperValue = 500;
    UIImage* image = nil;
    
    image = [UIImage imageWithColor:AHYGrey28];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    _slider.trackBackgroundImage = image;
    
    image = [UIImage imageWithColor:AHYYellow];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    _slider.trackImage = image;
    
    image = [UIImage imageNamed:@"sliderHandle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    _slider.lowerHandleImageNormal = image;
    _slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"sliderHandle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    _slider.lowerHandleImageHighlighted = image;
    _slider.upperHandleImageHighlighted = image;
}

- (void)configureStarsView {
    _starsView.count = 5;
    _starsView.rating = 1;
    _starsView.onColor = AHYYellow;
    _starsView.offColor = AHYGrey28;
    _starsView.delegate = self;
}

#pragma mark --responds

- (IBAction)cancelButtonPressed:(UIButton *)button {
    NSLog(@"%s:%@",__func__,self);
    [self hidden];
}

- (IBAction)resetButtonPressed:(UIButton *)button {
    NSLog(@"%s:%@",__func__,self);
    [self hidden];
}

- (IBAction)applyButtonPressed:(UIButton *)button {
    if(self.delegate && [self.delegate respondsToSelector:@selector(applyButtonDidPressed:)]) {
        [self.delegate applyButtonDidPressed:self];
    }
    NSLog(@"%s:%@",__func__,self);
    [self hidden];
}

- (IBAction)sliderValueChanged:(NMRangeSlider *)sender {
    // we get get the center point of the slider handles and use this to arrange other subviews
    CGPoint lowerCenter = _lowerPriceLabel.center;
    lowerCenter.x = (_slider.lowerCenter.x + _slider.frame.origin.x);
    _lowerPriceLabel.center = lowerCenter;
    _lowerPriceLabel.text = [NSString stringWithFormat:@"$%d", (int)_slider.lowerValue];
    
    CGPoint upperCenter = _upperPriceLabel.center;
    upperCenter.x = (_slider.upperCenter.x + _slider.frame.origin.x);
    _upperPriceLabel.center = upperCenter;
    _upperPriceLabel.text = [NSString stringWithFormat:@"$%d+", (int)_slider.upperValue];
}

- (IBAction)tapGestureTouched:(id)sender {
    NSLog(@"%s",__func__);
    [self hidden];
}

#pragma mark --RFSegmentViewDelegate

- (void)segmentViewDidSelected:(NSUInteger)index {
    NSLog(@"%s:%d",__func__,(int)index);
}

#pragma mark --AVStarsViewDelegate

- (void)starsViewRatingChanged:(AVStarsView *)starsView {
    _starsLabel.text = [NSString stringWithFormat:@"%d+star",(int)starsView.rating];
}

@end
