//
//  CustomTableViewCell.h
//  Ahoy
//
//  Created by chunlian on 15/11/11.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EmptyCell,
} TableViewCellStyle;

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *subTitleLabel;
@property (nonatomic, strong) UILabel   *descLabel;
@property (nonatomic, strong) UIView   *dividerView;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableViewCellStyle:(TableViewCellStyle)cellStyle;

@end
