//
//  UIUserTopicsView.m
//  Ahoy
//
//  Created by chunlian on 16/1/18.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "UIUserTopicsView.h"
#import "CustomTableViewCell.h"
#import "Utility.h"
#import "Masonry.h"

#define leftOffset  15

@interface UIUserTopicsView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation UIUserTopicsView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, frame.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.pagingEnabled = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        _tableView.bounces = YES;
        _tableView.directionalLockEnabled = YES;
        _tableView.alwaysBounceHorizontal = NO;
        _tableView.alwaysBounceVertical = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
        return self;
    }
    return nil;
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TopicsCell";

    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:EmptyCell];
        
        cell.cellImage = [[UIImageView alloc] init];
        [cell addSubview:cell.cellImage];
        
        cell.titleLabel = [[UILabel alloc] init];
        cell.titleLabel.numberOfLines = 1;
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.font = TradeGothicLTBoldTwo(16);
        cell.titleLabel.textColor = AHYGrey40;
        [cell addSubview:cell.titleLabel];
        
        cell.subTitleLabel = [[UILabel alloc] init];
        cell.subTitleLabel.numberOfLines = 1;
        cell.subTitleLabel.backgroundColor = [UIColor whiteColor];
        cell.subTitleLabel.font = TradeGothicLT(12);
        cell.subTitleLabel.textColor = AHYSteelGrey;
        [cell addSubview:cell.subTitleLabel];

        cell.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, DeviceScreenWidth-leftOffset-85, 0)];
        cell.descLabel.numberOfLines = 0;
        cell.descLabel.backgroundColor = [UIColor whiteColor];
        cell.descLabel.font = AvenirNextRegular(16);
        cell.descLabel.textColor = AHYBlack100;
        [cell addSubview:cell.descLabel];
        
        cell.dividerView = [[UIView alloc] init];
        cell.dividerView.backgroundColor = AHYGrey10;
        [cell addSubview:cell.dividerView];
    }

    if (indexPath.row%2 == 0) {
        cell.cellImage.image = [UIImage imageNamed:@"c2Topic2Thumbnail"];
        cell.titleLabel.text = @"Pharetra Amet Inceptos";
        cell.subTitleLabel.text = @"(10 sold)";
        cell.descLabel.text = @"Lorem ipsum dolor sit amet, consect adipiscing elit. Sed posuere consecte est at lobortis. Donec sed odio duise. Integer posuere erat a ante venenatis dapibus posuere ve aliquet. Senean lacinia bibendum nulla sconsectetur. Cras justo odio, dapibus ac facilisis in, egestas eget qu. Aenean laciniase bibendum nulla se consectetur. ";
    } else {
        cell.cellImage.image = [UIImage imageNamed:@"c1Topic2Thumbnail"];
        cell.titleLabel.text = @"Fusce Mattis Mollis Nibh";
        cell.subTitleLabel.text = @"(6 sold)";
        cell.descLabel.text = @"Lorem dapibus, tellus ac cursusslieli commodo, tortor mauris conditum nibh, ut fermentum massa justo sit amet risus. Integer posuere erat ant. Venenatis dapibus posuere velit aliquet. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam id dolor id nibh ultricies fermentum. ";
    }
    
    [cell.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
        make.leading.mas_equalTo(leftOffset);
    }];
    
    [cell.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.cellImage.mas_top);
        make.width.mas_equalTo(DeviceScreenWidth-150);
        make.height.mas_equalTo(19);
        make.leading.equalTo(cell.cellImage.mas_trailing).mas_equalTo(10);
    }];
    
    [cell.subTitleLabel sizeToFit];
    [cell.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.cellImage.mas_top).offset(2);
        make.height.mas_equalTo(16);
        make.trailing.mas_equalTo(-leftOffset);
    }];
    
    [cell.descLabel sizeToFit];
    [cell.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.titleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(DeviceScreenWidth-leftOffset-85);
        make.leading.equalTo(cell.cellImage.mas_trailing).mas_equalTo(10);
    }];
    
    [cell.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.descLabel.mas_bottom).offset(38);
        make.width.mas_equalTo(DeviceScreenWidth-leftOffset);
        make.leading.mas_equalTo(leftOffset);
        make.height.mas_equalTo(0.5);
    }];

    return cell;
}


#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"Curabitur blandit tempus porttitor. Nullam quis risus eget urna mollis. Ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit. Fusce dapibus, tellus ac cursus commodo. Tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Aenean lacinia bibendum nulla sed consectetur. Curabitur blandit.";
    NSDictionary *attributes = @{NSFontAttributeName:AvenirNextRegular(16)};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(DeviceScreenWidth-leftOffset-85, MAXFLOAT)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attributes
                                    context:nil];
    return ceil(rect.size.height+53+39);
}



@end
