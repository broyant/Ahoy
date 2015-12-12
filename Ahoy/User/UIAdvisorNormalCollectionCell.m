//
//  UIAdvisorNormalCollectionCell.m
//  Ahoy
//
//  Created by chunlian on 15/12/10.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIAdvisorNormalCollectionCell.h"
#import "Masonry.h"

#define leftOffset  15

@implementation UIAdvisorNormalCollectionCell

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
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellImage.mas_bottom).offset(7);
            make.leading.equalTo(self.cellImage.mas_leading);
            make.size.mas_equalTo(CGSizeMake(90, 44));
        }];
    }
    return self;
}


@end
