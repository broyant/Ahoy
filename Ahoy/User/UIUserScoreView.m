//
//  UIUserScoreView.m
//  Ahoy
//
//  Created by chunlian on 15/11/11.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIUserScoreView.h"

@interface UIUserScoreView ()
{
    UILabel *_pointLabel;
    UILabel *_pointUnit;
    
    UILabel *_hourLabel;
    UILabel *_hourUnit;
}

@end

@implementation UIUserScoreView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 8, 95, 64)];
        _hourLabel.numberOfLines = 1;
        _hourLabel.backgroundColor = [UIColor whiteColor];
        _hourLabel.font = TradeGothicLTBold(54);
        _hourLabel.textColor = RGBCOLORA(193, 194, 195, 1);
        _hourLabel.text = @"$66";
        [self addSubview:_hourLabel];
        
        _hourUnit = [[UILabel alloc] initWithFrame:CGRectMake(93, 48, 48, 21)];
        _hourUnit.numberOfLines = 1;
        _hourUnit.backgroundColor = [UIColor clearColor];
        _hourUnit.font = TradeGothicLTBold(18);
        _hourUnit.textColor = AHYBlue;
        _hourUnit.text = @"/HOUR";
        [self addSubview:_hourUnit];
        
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 8, 94, 64)];
        _pointLabel.numberOfLines = 1;
        _pointLabel.backgroundColor = [UIColor whiteColor];
        _pointLabel.font = TradeGothicLTBold(54);
        _pointLabel.textColor = RGBCOLORA(193, 194, 195, 1);
        _pointLabel.text = @"268";
        [self addSubview:_pointLabel];
        
        _pointUnit = [[UILabel alloc] initWithFrame:CGRectMake(265, 48, 63, 22)];
        _pointUnit.numberOfLines = 1;
        _pointUnit.backgroundColor = [UIColor clearColor];
        _pointUnit.font = TradeGothicLTBold(18);
        _pointUnit.textColor = AHYBlue;
        _pointUnit.text = @"/POINTS";
        [self addSubview:_pointUnit];
        
        return self;
    }
    return nil;
}


@end
