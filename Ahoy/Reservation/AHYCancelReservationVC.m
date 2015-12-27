//
//  AHYCancelReservationVC.m
//  Ahoy
//
//  Created by chunlian on 15/12/22.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYCancelReservationVC.h"
#import "CustomTableViewCell.h"

#define bottomHeight    50
#define leftOffset      15
#define tableCellHeight      50

@interface AHYCancelReservationVC ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray  *_data;
    
    NSInteger   _selectIndex;
}

@end

@implementation AHYCancelReservationVC

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = AHYBlue;
    self.navigationItem.title = @"CANCEL RESERVATION";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+kStatusBarHeight, DeviceScreenWidth, DeviceScreenHeight-kNavBarHeight-kStatusBarHeight-bottomHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.pagingEnabled = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollsToTop = NO;
    _tableView.bounces = YES;
    _tableView.directionalLockEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIButton  *confirm = [[UIButton alloc] initWithFrame:CGRectMake(0, DeviceScreenHeight-bottomHeight, DeviceScreenWidth, bottomHeight)];
    [confirm setBackgroundColor:AHYRed];
    [confirm setTitleColor:AHYWhite forState:UIControlStateNormal];
    [confirm setTitleEdgeInsets:UIEdgeInsetsMake(15, 0, 13, 0)];
    confirm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    confirm.titleLabel.font = TradeGothicLTBoldTwo(18);
    [confirm setTitle:@"Confirm Cancellation" forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(confirmBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _data = [NSMutableArray arrayWithObjects:@"I don’t need it anymore", @"I just want change the schedule", @"I found a better advisor", @"Oops, wrong credit card", @"Other", nil];
    _selectIndex = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, 62)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 20, DeviceScreenWidth-2*leftOffset, 38)];
    title.numberOfLines = 0;
    title.backgroundColor = [UIColor whiteColor];
    title.font = TradeGothicLTBoldTwo(14);
    title.textColor = AHYGrey40;
    title.text = @"PLEASE HELP US UNDERSTAND THE REASON FOR THE CANCELLATION REQUEST";
    [header addSubview:title];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 62;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tableViewCellStyle:EmptyCell];
        
        cell.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 0, DeviceScreenWidth-2*leftOffset, tableCellHeight)];
        cell.titleLabel.numberOfLines = 1;
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.font = AvenirNextRegular(16);
        cell.titleLabel.textColor = AHYBlack100;
        [cell addSubview:cell.titleLabel];
        
        cell.cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceScreenWidth-36, 19, 16, 12)];
        cell.cellImage.image = [UIImage imageNamed:@"reservationCheckMark"];
        [cell addSubview:cell.cellImage];
        
        cell.dividerView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, tableCellHeight-1, DeviceScreenWidth-leftOffset, 0.5)];
        cell.dividerView.backgroundColor = AHYGrey10;
        [cell addSubview:cell.dividerView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.titleLabel.text = [_data objectAtIndex:indexPath.row];
    cell.cellImage.hidden = YES;
    
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectIndex >= 0 && _selectIndex != indexPath.row) {
        CustomTableViewCell *old = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]];
        old.cellImage.hidden = YES;
    }
    
    CustomTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.cellImage.hidden) {
        cell.cellImage.hidden = NO;
        _selectIndex = indexPath.row;
    } else {
        cell.cellImage.hidden = YES;
        _selectIndex = -1;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableCellHeight;
}


#pragma mark Button function

- (void)confirmBtnTouched
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                        message:@"Are you sure you want to cancel this reservation?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
    [alertView show];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - AlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.firstOtherButtonIndex == buttonIndex)
    {
        NSLog(@"删除 Reservation ！！！");
    }
}

@end
