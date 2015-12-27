//
//  AHYReviewReservationVC.m
//  Ahoy
//
//  Created by chunlian on 15/12/25.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYReviewReservationVC.h"
#import "Masonry.h"
#import "UIAdvisePageScrollView.h"
#import "AHYCancelReservationVC.h"
#import "AHYReservationVC.h"

#define leftOffset      15

#define topicScrollViewHeight     176


@interface AHYReviewReservationVC ()<AdviseScrollViewDelegate>
{
    UIScrollView *_scrollView;
}

@end

@implementation AHYReviewReservationVC

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = AHYBlue;
    self.navigationItem.title = @"RESERVATION";
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Modify" style:UIBarButtonItemStylePlain target:self action:@selector(modifyAction)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    //    scrollView.delegate = self;
    _scrollView.scrollEnabled = true;
    _scrollView.bounces = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kStatusBarHeight+kNavBarHeight);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth, DeviceScreenHeight-kStatusBarHeight-kNavBarHeight));
    }];
    
    UIView  *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
    }];
    
    UILabel *timeTitle = [[UILabel alloc] init];
    timeTitle.numberOfLines = 1;
    timeTitle.backgroundColor = [UIColor whiteColor];
    timeTitle.font = TradeGothicLTBoldTwo(14);
    timeTitle.textColor = AHYGrey40;
    timeTitle.text = @"WHAT TIME YOU WANT TO TALK";
    [contentView addSubview:timeTitle];
    [timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 19));
        make.leading.offset(leftOffset);
    }];

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.numberOfLines = 1;
    timeLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.font = AvenirNextRegular(16);
    timeLabel.textColor = AHYBlack100;
    timeLabel.text = @"4:30 pm to 5:30 pm,  Sun, Oct 27";
    [contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeTitle.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 22));
        make.leading.offset(leftOffset);
    }];
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = AHYGrey10;
    [contentView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(18);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-leftOffset, 0.5));
    }];
    
    UILabel *payTitle = [[UILabel alloc] init];
    payTitle.numberOfLines = 1;
    payTitle.backgroundColor = [UIColor whiteColor];
    payTitle.font = TradeGothicLTBoldTwo(14);
    payTitle.textColor = AHYGrey40;
    payTitle.text = @"HOW MUCH YOU HAVE PAID";
    [contentView addSubview:payTitle];
    [payTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dividerView.mas_bottom).offset(23);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 19));
        make.leading.offset(leftOffset);
    }];
    
    UILabel *payLabel = [[UILabel alloc] init];
    payLabel.numberOfLines = 1;
    payLabel.backgroundColor = [UIColor clearColor];
    payLabel.font = AvenirNextRegular(16);
    payLabel.textColor = AHYWhite;
    payLabel.text = @"Paid: $148";
    [payLabel sizeToFit];
    
    UIView *payBG = [[UIView alloc] init];
    payBG.backgroundColor = AHYGrey28;
    [contentView addSubview:payBG];
    [payBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dividerView.mas_bottom).offset(19);
        make.right.equalTo(dividerView.mas_right);
        make.width.mas_equalTo(payLabel.frame.size.width+12);
        make.height.mas_equalTo(28);
    }];

    [payBG addSubview:payLabel];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(payBG).with.insets(UIEdgeInsetsMake(4, 6, 2, 4));
    }];
    
    UIAdvisePageScrollView *topicScroll = [[UIAdvisePageScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, topicScrollViewHeight) scrollType:CollectionSelectScroll];
    topicScroll.delegate = self;
    topicScroll.backgroundColor = [UIColor clearColor];
    [contentView addSubview:topicScroll];
    [topicScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payBG.mas_bottom).offset(23);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth, topicScrollViewHeight));
    }];
    
    UIView *dividerView1 = [[UIView alloc] init];
    dividerView1.backgroundColor = AHYGrey10;
    [contentView addSubview:dividerView1];
    [dividerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topicScroll.mas_bottom).offset(17);
        make.leading.offset(leftOffset);
        make.size.equalTo(dividerView);
    }];

    UILabel *prepareTitle = [[UILabel alloc] init];
    prepareTitle.numberOfLines = 1;
    prepareTitle.backgroundColor = [UIColor whiteColor];
    prepareTitle.font = TradeGothicLTBoldTwo(14);
    prepareTitle.textColor = AHYGrey40;
    prepareTitle.text = @"HELP THE HOWARD PREPARE THE CALL";
    [contentView addSubview:prepareTitle];
    [prepareTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dividerView1.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(261, 19));
        make.leading.offset(leftOffset);
    }];
    
    UILabel *preparelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth-2*leftOffset, 0)];
    preparelabel.numberOfLines = 0;
    preparelabel.backgroundColor = [UIColor whiteColor];
    preparelabel.font = AvenirNextRegular(16);
    preparelabel.textColor = AHYBlack100;
    preparelabel.text = @"Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit sit amet non magna.";
    [contentView addSubview:preparelabel];
    [preparelabel sizeToFit];
    [preparelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(prepareTitle.mas_bottom).offset(16);
        make.leading.offset(leftOffset);
        make.width.mas_equalTo(DeviceScreenWidth-2*leftOffset);
    }];
    
    UIView *dividerView2 = [[UIView alloc] init];
    dividerView2.backgroundColor = AHYGrey10;
    [contentView addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(preparelabel.mas_bottom).offset(19);
        make.leading.offset(leftOffset);
        make.size.equalTo(dividerView);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setBackgroundColor:AHYWhite];
    [cancelBtn setTitleColor:AHYRed forState:UIControlStateNormal];
    [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(9, 0, 10, 0)];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    cancelBtn.titleLabel.font = TradeGothicLT(18);
    [cancelBtn setTitle:@"Cancel The Reservation" forState:UIControlStateNormal];
    [cancelBtn.layer setBorderWidth:1];
    [cancelBtn.layer setCornerRadius:1];
    [cancelBtn.layer setBorderColor:AHYRed.CGColor];
    [cancelBtn.layer setMasksToBounds:YES];
    [cancelBtn addTarget:self action:@selector(cancelBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dividerView2.mas_bottom).offset(24);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 40));
    }];
    
    UILabel *cancelNote = [[UILabel alloc] init];
    cancelNote.numberOfLines = 0;
    cancelNote.backgroundColor = [UIColor whiteColor];
    cancelNote.font = TradeGothicLTItalic(14);
    cancelNote.textColor = AHYSteelGrey;
    cancelNote.text = @"Note: Be aware that you can only modify or cancell the reservation 6 hours prior to the reserved time. So the advisor can better be prepared for the change. :) ";
    [contentView addSubview:cancelNote];
    [cancelNote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelBtn.mas_bottom).offset(22);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 50));
        make.leading.offset(leftOffset);
    }];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cancelNote.mas_bottom).offset(60);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelBtnTouched
{
    AHYCancelReservationVC  *vc = [[AHYCancelReservationVC alloc] init];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:vc animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

- (void)didSelectedItem:(NSInteger)row
{
    
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)modifyAction
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    [[self navigationController].view.layer addAnimation:transition forKey:@"fadeTransition"];
    
    AHYReservationVC *vc = [[AHYReservationVC alloc] init];
    vc.reservationType = modifyReservation;
    [self.navigationController pushViewController:vc animated:NO];
}

@end
