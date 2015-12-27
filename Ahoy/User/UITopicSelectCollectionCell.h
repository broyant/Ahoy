//
//  UITopicSelectCollectionCell.h
//  Ahoy
//
//  Created by chunlian on 15/12/16.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITopicSelectCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIImageView   *cellImage;
@property (nonatomic, assign) BOOL  isSelected;

@end
