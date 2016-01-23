//
//  AHYSettingTableViewCell.m
//  Ahoy
//
//  Created by lichuanjun on 17/1/2016.
//  Copyright © 2016 Ahoy. All rights reserved.
//

#import "AHYSettingTableViewCell.h"

@implementation AHYSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = AHYBlack100;
    self.titleLabel.font = AvenirNextRegular(16);
    self.separateLine.backgroundColor = AHYGrey10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
