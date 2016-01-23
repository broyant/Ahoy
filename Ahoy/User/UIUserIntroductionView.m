//
//  UIUserIntroductionView.m
//  Ahoy
//
//  Created by chunlian on 15/11/11.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "UIUserIntroductionView.h"
#import "CustomTableViewCell.h"
#import "Masonry.h"
#import "Utility.h"

#define leftOffset   15
#define priceCellHeight     100
#define completionCellHeight     60

enum : NSUInteger {
    introductionSection = 0,
    experienceSection,
    educationSection,
};

@interface UIUserIntroductionView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UILabel     *_price;
    UILabel     *_completionRate;
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
        
        UIView  *priceCompletionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, priceCellHeight+completionCellHeight)];
        priceCompletionView.backgroundColor = [UIColor whiteColor];
        
        UILabel *priceTitle = [[UILabel alloc] init];
        priceTitle.text = @"ESTIMATED PRICE BASED ON YOUR PROFILE";
        priceTitle.font = TradeGothicLTBoldTwo(14);
        priceTitle.textColor = AHYGrey40;
        [priceCompletionView addSubview:priceTitle];
        [priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(18);
            make.width.mas_equalTo(DeviceScreenWidth-2*leftOffset);
            make.height.mas_equalTo(19);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        _price = [[UILabel alloc] init];
        _price.text = @"$54";
        _price.font = TradeGothicLTBold(28);
        _price.textColor = AHYGrey28;
        [priceCompletionView addSubview:_price];
        [_price sizeToFit];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceTitle.mas_bottom).offset(10);
            make.height.mas_equalTo(33);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        UILabel *priceSign = [[UILabel alloc] init];
        priceSign.text = @"/HR";
        priceSign.font = TradeGothicLTBoldTwo(14);
        priceSign.textColor = AHYBlack100;
        [priceCompletionView addSubview:priceSign];
        [priceSign mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceTitle.mas_bottom).offset(21);
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(19);
            make.leading.equalTo(_price.mas_trailing);
        }];
        
        UIImageView *forwadImage = [[UIImageView alloc] init];
        [forwadImage setImage:[UIImage imageNamed:@"forwardArrow"]];
        [priceCompletionView addSubview:forwadImage];
        [forwadImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceTitle.mas_bottom).offset(21);
            make.width.mas_equalTo(9);
            make.height.mas_equalTo(16);
            make.trailing.mas_equalTo(-leftOffset);
        }];
        
        UIView  *divider = [[UIView alloc] init];
        divider.backgroundColor = AHYGrey10;
        [priceCompletionView addSubview:divider];
        [divider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_price.mas_bottom).offset(18);
            make.width.mas_equalTo(DeviceScreenWidth-leftOffset);
            make.height.mas_equalTo(0.5);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        UILabel *completionTitle = [[UILabel alloc] init];
        completionTitle.text = @"PROFILE COMPLETION";
        completionTitle.font = TradeGothicLTBoldTwo(14);
        completionTitle.textColor = AHYGrey40;
        [priceCompletionView addSubview:completionTitle];
        [completionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(18+priceCellHeight);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(19);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        UIImageView *forwadImageView = [[UIImageView alloc] init];
        [forwadImageView setImage:[UIImage imageNamed:@"forwardArrow"]];
        [priceCompletionView addSubview:forwadImageView];
        [forwadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(completionTitle.mas_top).offset(1);
            make.width.mas_equalTo(9);
            make.height.mas_equalTo(16);
            make.trailing.mas_equalTo(-leftOffset);
        }];
        
        _completionRate = [[UILabel alloc] init];
        _completionRate.text = @"95%";
        _completionRate.font = AvenirNextRegular(16);
        _completionRate.textColor = AHYBlack100;
        [priceCompletionView addSubview:_completionRate];
        [_completionRate sizeToFit];
        [_completionRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(completionTitle.mas_top);
            make.height.mas_equalTo(22);
            make.trailing.equalTo(forwadImageView.mas_leading).offset(-16);
        }];
        
        UIView  *dividerView = [[UIView alloc] init];
        dividerView.backgroundColor = AHYGrey10;
        [priceCompletionView addSubview:dividerView];
        [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(completionTitle.mas_bottom).offset(21);
            make.width.mas_equalTo(DeviceScreenWidth-leftOffset);
            make.height.mas_equalTo(0.5);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        _tableView.tableHeaderView = priceCompletionView;
        
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
    if (section == introductionSection) {
        return 4;
    } else if (section == experienceSection) {
        return 3;
    }
    return 2;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == introductionSection) {
        return nil;
    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, 48)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 18, DeviceScreenWidth-2*leftOffset, 19)];
    title.numberOfLines = 1;
    title.backgroundColor = [UIColor whiteColor];
    title.font = TradeGothicLTBoldTwo(14);
    title.textColor = AHYGrey40;
    [header addSubview:title];
    
    if (section == experienceSection) {
        title.text = @"WORK EXPERIENCE";
    } else if (section == educationSection) {
        title.text = @"EDUCATION";
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == introductionSection) {
        return 0;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = nil;
    
    if (indexPath.section == introductionSection) {
        static NSString *CellIdentifier = @"TitleAndDescriptionCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:EmptyCell];
            
            cell.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 18, DeviceScreenWidth-2*leftOffset, 19)];
            cell.titleLabel.numberOfLines = 1;
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.font = TradeGothicLTBoldTwo(14);
            cell.titleLabel.textColor = AHYGrey40;
            [cell addSubview:cell.titleLabel];
            
            cell.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 48, DeviceScreenWidth-2*leftOffset, 0)];
            cell.descLabel.numberOfLines = 0;
            cell.descLabel.backgroundColor = [UIColor whiteColor];
            cell.descLabel.font = AvenirNextRegular(16);
            cell.descLabel.textColor = AHYBlack100;
            [cell addSubview:cell.descLabel];
            
            cell.dividerView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, 0, DeviceScreenWidth-leftOffset, 0.5)];
            cell.dividerView.backgroundColor = AHYGrey10;
            [cell addSubview:cell.dividerView];
        }
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"CURRENT MISSION";
            cell.descLabel.text = @"Shipping Ahoy & Make a dent in the universe!";
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"ONE AMAZING THING I’VE DONE";
            cell.descLabel.text = @"Started Ahoy with best people I know. And now Ahoy has an active community with more than 10 million curious learners and 2 million mentors sharing their experience everyday.";
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"WHY I’M ON AHOY";
            cell.descLabel.text = @"I was introduced by several of my friends, who I have always trusted their recommendations.";
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = @"WHAT I EXPECT TO LEARN";
            cell.descLabel.text = @"I want to know more about how to build a successful product and start a company that does great things.";
        }
        [cell.descLabel sizeToFit];
        
        [Utility changeY:cell.dividerView y:cell.descLabel.frame.origin.y+cell.descLabel.frame.size.height+19];
        
    } else if (indexPath.section == experienceSection) {
        static NSString *CellIdentifier = @"ExperienceCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:EmptyCell];
            
            cell.titleLabel = [[UILabel alloc] init];
            cell.titleLabel.numberOfLines = 1;
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.font = AvenirNextMedium(16);
            cell.titleLabel.textColor = RGBCOLORA(77, 77, 77, 1);
            [cell addSubview:cell.titleLabel];
            
            cell.subTitleLabel = [[UILabel alloc] init];
            cell.subTitleLabel.numberOfLines = 1;
            cell.subTitleLabel.backgroundColor = [UIColor whiteColor];
            cell.subTitleLabel.font = AvenirNextRegular(14);
            cell.subTitleLabel.textColor = AHYGrey40;
            [cell addSubview:cell.subTitleLabel];
            
            cell.otherLabel = [[UILabel alloc] init];
            cell.otherLabel.numberOfLines = 1;
            cell.otherLabel.backgroundColor = [UIColor whiteColor];
            cell.otherLabel.font = TradeGothicLT(12);
            cell.otherLabel.textColor = AHYSteelGrey;
            [cell addSubview:cell.otherLabel];
            
            cell.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 0, DeviceScreenWidth-2*leftOffset, 0)];
            cell.descLabel.numberOfLines = 0;
            cell.descLabel.backgroundColor = [UIColor whiteColor];
            cell.descLabel.font = AvenirNextRegular(16);
            cell.descLabel.textColor = AHYBlack100;
            [cell addSubview:cell.descLabel];
            
            cell.dividerView = [[UIView alloc] init];
            cell.dividerView.backgroundColor = AHYGrey10;
            [cell addSubview:cell.dividerView];
        }
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"User Experience Designer";
            cell.subTitleLabel.text = @"Scopely";
            cell.otherLabel.text = @"08/2014 - 10/2015";
            cell.descLabel.text = @"Developed mobile games, such as Yathzee and others. Web interface design, application development, online video, and custom CMS module development.";
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"User Experience Designer";
            cell.subTitleLabel.text = @"Sourcebits, Inc";
            cell.otherLabel.text = @"08/2014 - 10/2015";
            cell.descLabel.text = @"Redesigned the company website: http://www.sourcebits.com. Rebranded the company identity, including logo, typography, marketing collaterals, and wrote a comprehensive brand guide.";
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"Innovation Design Lead";
            cell.subTitleLabel.text = @"JCPenney Innovation Lab";
            cell.otherLabel.text = @"06/2015 - 10/2015";
            cell.descLabel.text = @"Concepted, prototyped and user tested all mobile innovation projects with high NPS. Redesign JCPenney Consumer iOS app. Redesigned product review for www.jcpenney.com with consideration of gamification.";
        }
        
        [cell.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (indexPath.row == 0) {
                make.top.offset(0);
            } else {
                make.top.offset(18);
            }
            make.width.mas_equalTo(DeviceScreenWidth-2*leftOffset);
            make.height.mas_equalTo(22);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        [cell.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.titleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(DeviceScreenWidth-2*leftOffset-120);
            make.height.mas_equalTo(19);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        [cell.otherLabel sizeToFit];
        [cell.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.subTitleLabel.mas_top).offset(1);
            make.height.mas_equalTo(16);
            make.trailing.mas_equalTo(-leftOffset);
        }];
        
        [cell.descLabel sizeToFit];
        [cell.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.subTitleLabel.mas_bottom).offset(4);
            make.width.mas_equalTo(DeviceScreenWidth-2*leftOffset);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        [cell.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.descLabel.mas_bottom).offset(19);
            make.width.mas_equalTo(DeviceScreenWidth-leftOffset);
            make.leading.mas_equalTo(leftOffset);
            make.height.mas_equalTo(0.5);
        }];

    } else if (indexPath.section == educationSection) {
        static NSString *CellIdentifier = @"EducationCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:EmptyCell];
            
            cell.titleLabel = [[UILabel alloc] init];
            cell.titleLabel.numberOfLines = 1;
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.font = AvenirNextMedium(16);
            cell.titleLabel.textColor = RGBCOLORA(77, 77, 77, 1);
            [cell addSubview:cell.titleLabel];
            
            cell.otherLabel = [[UILabel alloc] init];
            cell.otherLabel.numberOfLines = 1;
            cell.otherLabel.backgroundColor = [UIColor whiteColor];
            cell.otherLabel.font = TradeGothicLT(12);
            cell.otherLabel.textColor = AHYSteelGrey;
            [cell addSubview:cell.otherLabel];
            
            cell.subTitleLabel = [[UILabel alloc] init];
            cell.subTitleLabel.numberOfLines = 1;
            cell.subTitleLabel.backgroundColor = [UIColor whiteColor];
            cell.subTitleLabel.font = AvenirNextRegular(14);
            cell.subTitleLabel.textColor = AHYGrey40;
            [cell addSubview:cell.subTitleLabel];
        }
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"University of Texas at Austin";
            cell.otherLabel.text = @"08/2014 - 10/2015";
            cell.subTitleLabel.text = @"Master of Science in Human Computer Interaction";
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"Nankai University";
            cell.otherLabel.text = @"09/2007 - 06/2012";
            cell.subTitleLabel.text = @"Bachelor of Software Engineering";
        }
        
        [cell.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.width.mas_equalTo(DeviceScreenWidth-2*leftOffset-120);
            make.height.mas_equalTo(22);
            make.leading.mas_equalTo(leftOffset);
        }];
        
        [cell.otherLabel sizeToFit];
        [cell.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.titleLabel.mas_top).offset(3);
            make.height.mas_equalTo(16);
            make.trailing.mas_equalTo(-leftOffset);
        }];
        
        [cell.subTitleLabel sizeToFit];
        [cell.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.titleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(DeviceScreenWidth-2*leftOffset);
            make.leading.mas_equalTo(leftOffset);
        }];
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
    if (indexPath.section == introductionSection) {
        NSString *str = @"Shipping Ahoy & Make a dent in the universe!";
        if (indexPath.row == 1) {
            str = @"Started Ahoy with best people I know. And now Ahoy has an active community with more than 10 million curious learners and 2 million mentors sharing their experience everyday.";
        } else if (indexPath.row == 2) {
            str = @"I was introduced by several of my friends, who I have always trusted their recommendations.";
        } else if (indexPath.row == 3) {
            str = @"I want to know more about how to build a successful product and start a company that does great things.";
        }
        NSDictionary *attributes = @{NSFontAttributeName:AvenirNextRegular(16)};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(DeviceScreenWidth-2*leftOffset, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
        return ceil(rect.size.height+68);
    } else if (indexPath.section == experienceSection) {
        NSString *str = @"Developed mobile games, such as Yathzee and others. Web interface design, application development, online video, and custom CMS module development.";
        if (indexPath.row == 1) {
            str = @"Redesigned the company website: http://www.sourcebits.com. Rebranded the company identity, including logo, typography, marketing collaterals, and wrote a comprehensive brand guide.";
        } else if (indexPath.row == 2) {
            str = @"Concepted, prototyped and user tested all mobile innovation projects with high NPS. Redesign JCPenney Consumer iOS app. Redesigned product review for www.jcpenney.com with consideration of gamification.";
        }
        NSDictionary *attributes = @{NSFontAttributeName:AvenirNextRegular(16)};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(DeviceScreenWidth-2*leftOffset, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
        
        if (indexPath.row == 0) {
            return ceil(rect.size.height+50+20);
        }

        return ceil(rect.size.height+68+20);
    } else if (indexPath.section == educationSection) {
        NSString *str = @"Master of Science in Human Computer Interaction";
        if (indexPath.row == 1) {
            str = @"Bachelor of Software Engineering";
        }
        NSDictionary *attributes = @{NSFontAttributeName:AvenirNextMedium(14)};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(DeviceScreenWidth-2*leftOffset, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
        return ceil(rect.size.height+41);
    }
    
    return 0;
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

- (void)setTableViewFooter:(UIView *)view
{
    _tableView.tableFooterView = view;
}


@end
