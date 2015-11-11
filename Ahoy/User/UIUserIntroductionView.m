//
//  UIUserIntroductionView.m
//  Ahoy
//
//  Created by chunlian on 15/11/11.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIUserIntroductionView.h"
#import "CustomTableViewCell.h"

#define leftOffset   15

@interface UIUserIntroductionView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end
        

@implementation UIUserIntroductionView

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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    }
    return 2;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, 50)];
    header.backgroundColor = [UIColor whiteColor];
    
    UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, 0, DeviceScreenWidth-2*leftOffset, 0.5)];
    dividerView.backgroundColor = AHYGrey10;
    [header addSubview:dividerView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 19, DeviceScreenWidth-2*leftOffset, 19)];
    title.numberOfLines = 1;
    title.backgroundColor = [UIColor whiteColor];
    title.font = TradeGothicLTBoldTwo(14);
    title.textColor = RGBCOLORA(55, 71, 79, 1);
    title.text = @"ONE AMAZING THING I’VE DONE";
    [header addSubview:title];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ThingCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:EmptyCell];
            
            cell.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 0, DeviceScreenWidth-2*leftOffset, 0)];
            cell.titleLabel.numberOfLines = 0;
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.font = AvenirNextRegular(16);
            cell.titleLabel.textColor = AHYBlack100;
            [cell addSubview:cell.titleLabel];
        }
        cell.titleLabel.text = @"Started Ahoy with best people I know. And now Ahoy has an active community with more than 10 million curious learners and 2 million mentors sharing their experience everyday.";
        [cell.titleLabel sizeToFit];        
    } else {
        static NSString *CellIdentifier = @"TwoLineCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:EmptyCell];
            
            cell.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 0, DeviceScreenWidth-3*leftOffset-106, 22)];
            cell.titleLabel.numberOfLines = 1;
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.font = AvenirNextMedium(16);
            cell.titleLabel.textColor = RGBCOLORA(77, 77, 77, 1);
            [cell addSubview:cell.titleLabel];
            
            cell.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, cell.titleLabel.frame.size.height+5, DeviceScreenWidth-2*leftOffset, 19)];
            cell.subTitleLabel.numberOfLines = 1;
            cell.subTitleLabel.backgroundColor = [UIColor whiteColor];
            cell.subTitleLabel.font = AvenirNextRegular(14);
            cell.subTitleLabel.textColor = RGBCOLORA(77, 77, 77, 1);
            [cell addSubview:cell.subTitleLabel];
            
            cell.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.titleLabel.frame.origin.x+cell.titleLabel.frame.size.width+leftOffset, 3, 106, 16)];
            cell.descLabel.numberOfLines = 1;
            cell.descLabel.backgroundColor = [UIColor whiteColor];
            cell.descLabel.font = TradeGothicLT(12);
            cell.descLabel.textColor = AHYGrey56;
            [cell addSubview:cell.descLabel];
        }
        
        cell.titleLabel.text = @"Scopely";
        cell.subTitleLabel.text = @"User Experience Designer";
        cell.descLabel.text = @"08/2014 - 10/2015";
    }
    return cell;
}



#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *str = @"Started Ahoy with best people I know. And now Ahoy has an active community with more than 10 million curious learners and 2 million mentors sharing their experience everyday.";
        NSDictionary *attributes = @{NSFontAttributeName:AvenirNextRegular(16)};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(DeviceScreenWidth-2*leftOffset, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        return ceil(rect.size.height+18);
    }
    return 60;
}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


- (void)setTableViewHeader:(UIView *)view
{
    _tableView.tableHeaderView = view;
}


@end
