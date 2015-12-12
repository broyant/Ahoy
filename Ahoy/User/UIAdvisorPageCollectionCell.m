//
//  UIAdvisorPageCollectionCell.m
//  Ahoy
//
//  Created by chunlian on 15/12/10.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIAdvisorPageCollectionCell.h"
#import "Masonry.h"

#define leftOffset  15

@implementation UIAdvisorPageCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellImage = [[UIImageView alloc] init];
        [self addSubview:self.cellImage];
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(leftOffset);
            make.size.mas_equalTo(CGSizeMake(90, 90));
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = TradeGothicLT(16);
        self.titleLabel.textColor = AHYGrey40;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellImage.mas_bottom).offset(10);
            make.leading.equalTo(self.cellImage.mas_leading);
            make.size.mas_equalTo(CGSizeMake(90, 22));
        }];
        
        self.dividerView = [[UIView alloc] init];
        self.dividerView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.dividerView];
        [self.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
            make.leading.equalTo(self.cellImage.mas_leading);
            make.size.mas_equalTo(CGSizeMake(90, 1));
        }];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.titleLabel.textColor = AHYBlue;
        self.dividerView.backgroundColor = AHYBlue;
    } else {
        self.titleLabel.textColor = AHYGrey40;
        self.dividerView.backgroundColor = [UIColor clearColor];
    }
}

@end

