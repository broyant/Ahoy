//
//  CustomTableViewCell.m
//  Ahoy
//
//  Created by chunlian on 15/11/11.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

#define leftOffset  15

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableViewCellStyle:(TableViewCellStyle)cellStyle
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        switch (cellStyle) {
            case ReviewCell:
            {
                [self initWithReviewCell];
                break;
            }
            default:
                [self initWithEmptyCell];
                break;
        }
    }
    return self;
}

- (void)initWithEmptyCell {

}

- (void)initWithReviewCell
{
    self.cellImage = [[UIImageView alloc] init];
    [self addSubview:self.cellImage];
    [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = TradeGothicLT(16);
    self.titleLabel.textColor = AHYBlack100;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cellImage.mas_trailing).offset(9);
        make.height.mas_equalTo(19);
        make.right.mas_equalTo(66+70+leftOffset+8);
    }];
    
    self.starsView = [[AVStarsView alloc] initWithFrame:CGRectMake(0, 0, 70, 10)];
    self.starsView.count = 5;
    self.starsView.onColor = AHYYellow;
    self.starsView.offColor = AHYGrey28;
    [self addSubview:self.starsView];
    [self.starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(8);
        make.size.mas_equalTo(CGSizeMake(70, 10));
    }];
    
    // 日期
    self.otherLabel = [[UILabel alloc] init];
    self.otherLabel.font = TradeGothicLT(12);
    self.otherLabel.textColor = AHYGrey56;
    self.otherLabel.numberOfLines = 1;
    self.otherLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.otherLabel];
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(2);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(16);
    }];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.font = AvenirNextRegular(14);
    self.subTitleLabel.textColor = AHYGrey56;
    self.subTitleLabel.numberOfLines = 1;
    self.subTitleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(19);
    }];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.font = AvenirNextRegular(16);
    self.descLabel.textColor = AHYBlack100;
    self.descLabel.numberOfLines = 0;
    self.descLabel.backgroundColor = [UIColor clearColor];
    self.descLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [self addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellImage.mas_bottom).offset(10);
        make.leading.equalTo(self.cellImage.mas_leading);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(66);
    }];

}


@end
