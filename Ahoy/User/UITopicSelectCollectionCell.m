//
//  UITopicSelectCollectionCell.m
//  Ahoy
//
//  Created by chunlian on 15/12/16.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UITopicSelectCollectionCell.h"
#import "Masonry.h"

#define leftOffset  15

@interface UITopicSelectCollectionCell()
{
    UIView  *_selectedView;
    UIImageView  *_selectedImg;
}

@end

@implementation UITopicSelectCollectionCell

@synthesize isSelected = _isSelected;

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
        self.titleLabel.textColor = AHYBlack100;
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellImage.mas_bottom).offset(10);
            make.leading.equalTo(self.cellImage.mas_leading);
            make.size.mas_equalTo(CGSizeMake(90, 22));
        }];
        
        _selectedView = [[UIView alloc] init];
        _selectedView.backgroundColor = AHYBlue;
        _selectedView.alpha = 0.4;
        _selectedView.userInteractionEnabled = NO;
        [self.cellImage addSubview:_selectedView];
        [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(0);
            make.size.mas_equalTo(CGSizeMake(90, 90));
            make.top.offset(0);
        }];
        _selectedView.hidden = YES;
        
        _selectedImg = [[UIImageView alloc] init];
        _selectedImg.image = [UIImage imageNamed:@"checkMark"];
        [self.cellImage addSubview:_selectedImg];
        [_selectedImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(59);
            make.top.offset(64);
            make.size.mas_equalTo(CGSizeMake(21, 16));
        }];
        _selectedImg.hidden = YES;
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected) {
        _selectedView.hidden = NO;
        _selectedImg.hidden = NO;
        self.titleLabel.textColor = AHYBlue;
    } else {
        _selectedView.hidden = YES;
        _selectedImg.hidden = YES;
        self.titleLabel.textColor = AHYBlack100;
    }
}


@end
