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
        make.leading.mas_equalTo(leftOffset);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.top.mas_equalTo(24);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = AvenirNextMedium(16);
    self.titleLabel.textColor = RGBCOLORA(77, 77, 77, 1);
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(23);
        make.leading.equalTo(self.cellImage.mas_trailing).offset(10);
        make.height.mas_equalTo(22);
        make.trailing.mas_equalTo(-66-2*leftOffset);
    }];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.font = AvenirNextMedium(14);
    self.subTitleLabel.textColor = AHYGrey40;
    self.subTitleLabel.numberOfLines = 1;
    self.subTitleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(22);
    }];
    
    //日期
    self.otherLabel = [[UILabel alloc] init];
    self.otherLabel.font = TradeGothicLT(12);
    self.otherLabel.textColor = AHYSteelGrey;
    self.otherLabel.numberOfLines = 1;
    self.otherLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.otherLabel];
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(26);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(66);
    }];
    
    UILabel *rating = [[UILabel alloc] init];
    rating.font = AvenirNextMedium(16);
    rating.textColor = AHYGrey40;
    rating.numberOfLines = 1;
    rating.backgroundColor = [UIColor clearColor];
    rating.text = @"Overall Rating:";
    [self addSubview:rating];
    [rating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellImage.mas_bottom).offset(14);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(110, 22));
    }];
    
    self.starsView = [[AVStarsView alloc] initWithFrame:CGRectMake(0, 0, 95, 15)];
    self.starsView.count = 5;
    self.starsView.onColor = AHYYellow;
    self.starsView.offColor = AHYGrey28;
    [self addSubview:self.starsView];
    [self.starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellImage.mas_bottom).offset(15);
        make.trailing.offset(-leftOffset);
        make.size.mas_equalTo(CGSizeMake(95, 15));
    }];
    
    UILabel *value = [[UILabel alloc] init];
    value.font = AvenirNextMedium(16);
    value.textColor = AHYGrey40;
    value.numberOfLines = 1;
    value.backgroundColor = [UIColor clearColor];
    value.text = @"Value:";
    [self addSubview:value];
    [value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rating.mas_bottom).offset(8);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(46, 22));
    }];
    
    self.valueEvaluate = [[UILabel alloc] init];
    self.valueEvaluate.font = AvenirNextRegular(16);
    self.valueEvaluate.numberOfLines = 1;
    self.valueEvaluate.backgroundColor = [UIColor clearColor];
    self.valueEvaluate.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.valueEvaluate];
    [self.valueEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starsView.mas_bottom).offset(14);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(100);
    }];
    
    UILabel *communication = [[UILabel alloc] init];
    communication.font = AvenirNextMedium(16);
    communication.textColor = AHYGrey40;
    communication.numberOfLines = 1;
    communication.backgroundColor = [UIColor clearColor];
    communication.text = @"Communication:";
    [self addSubview:communication];
    [communication mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(value.mas_bottom).offset(8);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(122, 22));
    }];
    
    self.communicateEvaluate = [[UILabel alloc] init];
    self.communicateEvaluate.font = AvenirNextRegular(16);
    self.communicateEvaluate.numberOfLines = 1;
    self.communicateEvaluate.backgroundColor = [UIColor clearColor];
    self.communicateEvaluate.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.communicateEvaluate];
    [self.communicateEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueEvaluate.mas_bottom).offset(8);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(100);
    }];
    
    UILabel *friendliness = [[UILabel alloc] init];
    friendliness.font = AvenirNextMedium(16);
    friendliness.textColor = AHYGrey40;
    friendliness.numberOfLines = 1;
    friendliness.backgroundColor = [UIColor clearColor];
    friendliness.text = @"Friendliness:";
    [self addSubview:friendliness];
    [friendliness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(communication.mas_bottom).offset(8);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(93, 22));
    }];
    
    self.friendlyEvaluate = [[UILabel alloc] init];
    self.friendlyEvaluate.font = AvenirNextRegular(16);
    self.friendlyEvaluate.numberOfLines = 1;
    self.friendlyEvaluate.backgroundColor = [UIColor clearColor];
    self.friendlyEvaluate.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.friendlyEvaluate];
    [self.friendlyEvaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.communicateEvaluate.mas_bottom).offset(8);
        make.trailing.offset(-leftOffset);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(100);
    }];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth-2*leftOffset, 0)];
    self.descLabel.font = AvenirNextRegular(16);
    self.descLabel.textColor = AHYBlack100;
    self.descLabel.numberOfLines = 0;
    self.descLabel.backgroundColor = [UIColor clearColor];
    self.descLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [self addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.friendlyEvaluate.mas_bottom).offset(8);
        make.leading.offset(leftOffset);
        make.trailing.offset(-leftOffset);
    }];
    
    self.dividerView = [[UIView alloc] init];
    self.dividerView.backgroundColor = AHYGrey10;
    [self addSubview:self.dividerView];
    [self.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(DeviceScreenWidth-leftOffset);
        make.leading.mas_equalTo(leftOffset);
        make.height.mas_equalTo(0.5);
    }];
}


@end
