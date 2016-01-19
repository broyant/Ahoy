//
//  AHYReservationVC.m
//  Ahoy
//
//  Created by chunlian on 15/12/13.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYReservationVC.h"
#import "Masonry.h"
#import "UIAdvisePageScrollView.h"
#import "Utility.h"
#import "AHYReviewReservationVC.h"

#define leftOffset      15
#define bottomHeight    60

#define topicScrollViewHeight     176
#define datePickerHeight     216

@interface AHYReservationVC ()<UITextViewDelegate, AdviseScrollViewDelegate>
{
    UIView  *_messageView;
    UITextView  *_msgTextView;
    UIScrollView *_scrollView;
    UIDatePicker    *_datePicker;
    
    NSDate  *_startDate;
    NSDate  *_endDate;
    
    UIButton *_startBtn;
    UILabel *_startTimeLabel;
    UIButton *_endBtn;
    UILabel *_endTimeLabel;
    
    UILabel *_priceLabel;
    UILabel *_hoursLabel;
    UILabel *_payLabel;
    UIImageView *_payImage;
    
    NSInteger   _pickerIndex;
    
    //暂时的值
    BOOL    _hasTopic;
}

@end

@implementation AHYReservationVC

@synthesize reservationType = _reservationType;

- (id)init
{
    if (self = [super init]) {
        _reservationType = createReservation;
        return self;
    }
    return nil;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = AHYBlue;
    self.navigationItem.title = @"RESERVATION";
    
    if (_reservationType == createReservation) {
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        self.navigationItem.leftBarButtonItem = leftBarItem;
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Review" style:UIBarButtonItemStylePlain target:self action:@selector(reviewAction)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    } else if (_reservationType == modifyReservation) {
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBackAction)];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavBarHeight, DeviceScreenWidth, DeviceScreenHeight-kStatusBarHeight-kNavBarHeight-bottomHeight)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.scrollEnabled = true;
    _scrollView.bounces = YES;
    [self.view addSubview:_scrollView];
    
    CGFloat y = 20;
    
    if (true) {
        UILabel *descTitle = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, y, DeviceScreenWidth-2*leftOffset, 19)];
        descTitle.numberOfLines = 1;
        descTitle.backgroundColor = [UIColor whiteColor];
        descTitle.font = TradeGothicLTBoldTwo(14);
        descTitle.textColor = AHYGrey40;
        descTitle.text = @"WHAT TIME ADVISOR PREFERS";
        [_scrollView addSubview:descTitle];
        y += descTitle.frame.size.height + 16;
        
        UILabel *timeDesc = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, y, DeviceScreenWidth-2*leftOffset, 0)];
        timeDesc.numberOfLines = 0;
        timeDesc.backgroundColor = [UIColor whiteColor];
        timeDesc.font = AvenirNextRegular(16);
        timeDesc.textColor = AHYBlack100;
        timeDesc.text = @"I work from 9am to 6pm pst. The best time to reach to me is after 7:30pm weekdays. As for weekends, I am pretty flexible. Just send me an invite or text message on Ahoy.";
        [_scrollView addSubview:timeDesc];
        [timeDesc sizeToFit];
        y += timeDesc.frame.size.height + 17;
        
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, y, DeviceScreenWidth-leftOffset, 0.5)];
        dividerView.backgroundColor = AHYGrey10;
        [_scrollView addSubview:dividerView];
        y += 18;
    }

    UILabel *timePickerTitle = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, y, DeviceScreenWidth-2*leftOffset, 19)];
    timePickerTitle.numberOfLines = 1;
    timePickerTitle.backgroundColor = [UIColor whiteColor];
    timePickerTitle.font = TradeGothicLTBoldTwo(14);
    timePickerTitle.textColor = AHYGrey40;
    timePickerTitle.text = @"WHAT TIME YOU WANT TO TALK";
    [_scrollView addSubview:timePickerTitle];
    y += timePickerTitle.frame.size.height + 17;
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, DeviceScreenWidth/2+10, 65)];
    _startBtn.backgroundColor = AHYGrey10;
    [_startBtn setBackgroundImage:[UIImage imageNamed:@"startTimeBG"] forState:UIControlStateNormal];
    [_startBtn setTitleColor:AHYBlue forState:UIControlStateNormal];
    [_startBtn setTitleEdgeInsets:UIEdgeInsetsMake(32, leftOffset, 11, leftOffset)];
    _startBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _startBtn.titleLabel.font = TradeGothicLT(16);
    [_startBtn setTitle:@"Start Time..." forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(startBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_startBtn];
    
    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset, 12, _startBtn.frame.size.width-2*leftOffset, 16)];
    _startTimeLabel.numberOfLines = 1;
    _startTimeLabel.backgroundColor = [UIColor clearColor];
    _startTimeLabel.font = TradeGothicLT(12);
    _startTimeLabel.textColor = AHYBlue;
    _startTimeLabel.text = @"Date";
    [_startBtn addSubview:_startTimeLabel];
    
    _endBtn = [[UIButton alloc] initWithFrame:CGRectMake(_startBtn.frame.size.width, y, DeviceScreenWidth/2-10, 65)];
    [_endBtn setBackgroundColor:AHYGrey10];
    [_endBtn setTitleColor:AHYGrey40 forState:UIControlStateNormal];
    [_endBtn setTitleEdgeInsets:UIEdgeInsetsMake(32, 24, 11, 24)];
    _endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endBtn.titleLabel.font = TradeGothicLT(16);
    [_endBtn setTitle:@"End Time..." forState:UIControlStateNormal];
    [_endBtn addTarget:self action:@selector(endBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_endBtn];
    _endBtn.enabled = NO;
    
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 12, _startBtn.frame.size.width-42, 16)];
    _endTimeLabel.numberOfLines = 1;
    _endTimeLabel.backgroundColor = [UIColor clearColor];
    _endTimeLabel.font = TradeGothicLT(12);
    _endTimeLabel.textColor = AHYGrey40;
    _endTimeLabel.text = @"Date";
    [_endBtn addSubview:_endTimeLabel];
    
    y += _startBtn.frame.size.height;
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, y, DeviceScreenWidth, datePickerHeight)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.minimumDate = [NSDate date];
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_datePicker addTarget:self action:@selector(datePickerChanged) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:_datePicker];
    _datePicker.hidden = YES;
    
    _pickerIndex = -1;
    _startDate = [NSDate date];
    
    y += 24;
    
    _messageView = [[UIView alloc] initWithFrame:CGRectMake(0, y, DeviceScreenWidth, 341+topicScrollViewHeight+24)];//351
    _messageView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_messageView];
    
    y += _messageView.frame.size.height;
    [_scrollView setContentSize:CGSizeMake(DeviceScreenWidth, y)];

    UIAdvisePageScrollView *topicScroll = [[UIAdvisePageScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, topicScrollViewHeight) scrollType:CollectionSelectScroll];
    topicScroll.delegate = self;
    topicScroll.backgroundColor = [UIColor clearColor];
    [_messageView addSubview:topicScroll];
    
    UIView *dividerView2 = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, topicScrollViewHeight+24, DeviceScreenWidth-leftOffset, 0.5)];
    dividerView2.backgroundColor = AHYGrey10;
    [_messageView addSubview:dividerView2];
    
    UILabel *prepareTitle = [[UILabel alloc] init];
    prepareTitle.numberOfLines = 1;
    prepareTitle.backgroundColor = [UIColor whiteColor];
    prepareTitle.font = TradeGothicLTBoldTwo(14);
    prepareTitle.textColor = AHYGrey40;
    prepareTitle.text = @"HELP THE HOWARD PREPARE THE CALL";
    [_messageView addSubview:prepareTitle];
    [prepareTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dividerView2.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(261, 19));
        make.leading.offset(leftOffset);
    }];

    UILabel *prepareTip = [[UILabel alloc] init];
    prepareTip.numberOfLines = 1;
    prepareTip.backgroundColor = [UIColor whiteColor];
    prepareTip.font = AvenirNextRegular(12);
    prepareTip.textColor = AHYSteelGrey;
    prepareTip.text = @"(optional)";
    [_messageView addSubview:prepareTip];
    [prepareTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dividerView2.mas_bottom).offset(22);
        make.size.mas_equalTo(CGSizeMake(53, 16));
        make.trailing.equalTo(self.view.mas_trailing).offset(-leftOffset);
    }];
    
    UIView *textBg = [[UIView alloc] init];
    textBg.backgroundColor = [UIColor whiteColor];
    [textBg.layer setBorderColor:AHYGrey15.CGColor];
    [textBg.layer setBorderWidth:1];
    [textBg.layer setMasksToBounds:YES];
    [_messageView addSubview:textBg];
    [textBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(prepareTitle.mas_bottom).offset(17);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-2*leftOffset, 257)); //267
        make.leading.offset(leftOffset);
    }];
    
    _msgTextView = [[UITextView alloc] init];
    _msgTextView.backgroundColor = [UIColor whiteColor];
    _msgTextView.delegate = self;
    _msgTextView.textColor = AHYGrey40;
    _msgTextView.font = AvenirNextRegular(16);
    _msgTextView.text = @"LetHowardknowthepurposeofyourcallandw hatyou want to ask specifically，Let Howard know the purpose of your call and what you want to ask specifically，Let Howard know the purpose of your call and what you want to ask specifically，Let Howard know the purpose of your call and what you want to ask specifically，Let Howard know the purpose of your call and what you want to ask specifically…";
    _msgTextView.showsHorizontalScrollIndicator = NO;
    _msgTextView.showsVerticalScrollIndicator = YES;
    _msgTextView.bounces = YES;
    _msgTextView.directionalLockEnabled = YES;
    _msgTextView.returnKeyType = UIReturnKeyDone;
    [_msgTextView setContentInset:UIEdgeInsetsMake(-10, -5, -10, -5)];//原始内边距(-10, -5, -10, -5)
    [textBg addSubview:_msgTextView];
    [_msgTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(9);
        make.height.equalTo(textBg.mas_height).offset(-18);
        make.width.equalTo(textBg.mas_width).offset(-20);
        make.leading.offset(10);
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, DeviceScreenHeight-bottomHeight, DeviceScreenWidth, bottomHeight)];
    bottomView.backgroundColor = AHYYellow;
    [self.view addSubview:bottomView];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.numberOfLines = 1;
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.font = TradeGothicLTBoldTwo(20);
    _priceLabel.textColor = AHYWhite;
    _priceLabel.text = @"Price...";
    [bottomView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.leading.offset(leftOffset);
        make.size.mas_equalTo(CGSizeMake(DeviceScreenWidth-183-2*leftOffset, 25));
    }];

    _hoursLabel = [[UILabel alloc] init];
    _hoursLabel.numberOfLines = 1;
    _hoursLabel.backgroundColor = [UIColor clearColor];
    _hoursLabel.font = TradeGothicLT(12);
    _hoursLabel.textColor = AHYWhite;
    _hoursLabel.text = @"X hours in total";
    [bottomView addSubview:_hoursLabel];
    [_hoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom).offset(-2);
        make.leading.offset(leftOffset);
        make.width.equalTo(_priceLabel.mas_width);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *payBG = [[UIButton alloc] init];
    payBG.backgroundColor = [UIColor whiteColor];
    [payBG addTarget:self action:@selector(payReservationAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBG];
    [payBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_top);
        make.trailing.offset(-leftOffset);
        make.size.mas_equalTo(CGSizeMake(183, 40));
    }];
    
    _payLabel = [[UILabel alloc] init];
    _payLabel.numberOfLines = 1;
    _payLabel.backgroundColor = [UIColor clearColor];
    _payLabel.font = TradeGothicLT(18);
    _payLabel.textColor = AHYGrey28;
    _payLabel.text = @"Reserve With";
    [payBG addSubview:_payLabel];
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(7);
        make.leading.offset(14);
        make.size.mas_equalTo(CGSizeMake(103, 24));
    }];
    
    _payImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"applePay"]];
    [payBG addSubview:_payImage];
    [_payImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(12);
        make.trailing.offset(-leftOffset);
        make.size.mas_equalTo(CGSizeMake(43, 20));
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _scrollView.contentOffset = CGPointMake(0, topicScrollViewHeight+24+_messageView.frame.origin.y);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)startBtnTouched
{
    if (!_datePicker.hidden && _pickerIndex == 0) {
        _datePicker.hidden = YES;
        [Utility changeY:_messageView y:_messageView.frame.origin.y-datePickerHeight+24];
        [_scrollView setContentSize:CGSizeMake(DeviceScreenWidth, _scrollView.contentSize.height-datePickerHeight+24)];
        
        _endBtn.enabled = YES;
        if (_endDate == nil) {
            [_endBtn setTitleColor:AHYBlue forState:UIControlStateNormal];
            _endTimeLabel.textColor = AHYBlue;
        }
    } else {
        _datePicker.minimumDate = [NSDate date];
        if ([_startDate compare:[NSDate date]] == NSOrderedAscending) {
            _startDate = [NSDate date];
        }
        _datePicker.date = _startDate;

        NSDateFormatter *form= [[NSDateFormatter alloc] init];
        [form setDateFormat:@"EEE, MMM d"];
        NSString *str = [form stringFromDate:_startDate];
        _startTimeLabel.text = str;
        _startTimeLabel.textColor = AHYWhite;

        [form setDateFormat:@"K:mm aa"];
        NSString *time = [form stringFromDate:_startDate];
        [_startBtn setTitle:time forState:UIControlStateNormal];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"startTimeSelectedBG"] forState:UIControlStateNormal];
        [_startBtn setTitleColor:AHYWhite forState:UIControlStateNormal];
        
        if (_datePicker.hidden) {
            _datePicker.hidden = NO;
            [Utility changeY:_messageView y:_messageView.frame.origin.y+datePickerHeight-24];
            [_scrollView setContentSize:CGSizeMake(DeviceScreenWidth, _scrollView.contentSize.height+datePickerHeight-24)];
        }
    }
    _pickerIndex = 0;
}

- (void)endBtnTouched
{
    if (!_datePicker.hidden && _pickerIndex == 1) {
        _datePicker.hidden = YES;
        [Utility changeY:_messageView y:_messageView.frame.origin.y-datePickerHeight+24];
        [_scrollView setContentSize:CGSizeMake(DeviceScreenWidth, _scrollView.contentSize.height-datePickerHeight+24)];
        
        if (_startDate && _endDate) {
            NSInteger time = ceil([_endDate timeIntervalSinceDate:_startDate])/60;
            NSInteger hours = time/60;
            NSInteger minutes = time%60;
            
            if (hours > 0 && minutes > 0) {
                _hoursLabel.text = [NSString stringWithFormat:@"%ld hours and %ld minutes in total",hours,minutes];
            } else if (hours > 0) {
                _hoursLabel.text = [NSString stringWithFormat:@"%ld hours in total",hours];
            } else if (minutes > 0) {
                _hoursLabel.text = [NSString stringWithFormat:@"%ld minutes in total",minutes];
            }
            
            float price = time*50/60;
            _priceLabel.text = [NSString stringWithFormat:@"$%.1f",price];

            if (_hasTopic) {
                _payImage.image = [UIImage imageNamed:@"applePayHighlight"];
                _payLabel.textColor = AHYBlue;
            }
        }
    } else {
        _datePicker.maximumDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:_startDate];
        
        if (_endDate == nil) {
            _endDate = [NSDate dateWithTimeInterval:60*60 sinceDate:_startDate];
        }
        _datePicker.date = _endDate;

        NSDateFormatter *form= [[NSDateFormatter alloc] init];
        [form setDateFormat:@"EEE, MMM d"];
        NSString *str = [form stringFromDate:_endDate];
        _endTimeLabel.text = str;
        _endTimeLabel.textColor = AHYWhite;

        [form setDateFormat:@"K:mm aa"];
        NSString *time = [form stringFromDate:_endDate];
        [_endBtn setTitle:time forState:UIControlStateNormal];
        _endBtn.backgroundColor = AHYOrange;
        [_endBtn setTitleColor:AHYWhite forState:UIControlStateNormal];
        _startBtn.backgroundColor = AHYOrange;
        
        if (_datePicker.hidden) {
            _datePicker.hidden = NO;
            [Utility changeY:_messageView y:_messageView.frame.origin.y+datePickerHeight-24];
            [_scrollView setContentSize:CGSizeMake(DeviceScreenWidth, _scrollView.contentSize.height+datePickerHeight-24)];
        }
    }
    _pickerIndex = 1;
}

- (void)datePickerChanged
{
    if (_pickerIndex == 0) {
        _startDate = [_datePicker date];
        
        NSDateFormatter *form= [[NSDateFormatter alloc] init];
        [form setDateFormat:@"EEE, MMM d"];
        NSString *str = [form stringFromDate:_startDate];
        _startTimeLabel.text = str;
        
        [form setDateFormat:@"K:mm aa"];
        NSString *time = [form stringFromDate:_startDate];
        [_startBtn setTitle:time forState:UIControlStateNormal];
    } else if (_pickerIndex == 1) {
        _endDate = [_datePicker date];
        
        NSDateFormatter *form= [[NSDateFormatter alloc] init];
        [form setDateFormat:@"EEE, MMM d"];
        NSString *str = [form stringFromDate:_endDate];
        _endTimeLabel.text = str;
        
        [form setDateFormat:@"K:mm aa"];
        NSString *time = [form stringFromDate:_endDate];
        [_endBtn setTitle:time forState:UIControlStateNormal];
    }
}

- (void)didSelectedItem:(NSInteger)row
{
    if (row >= 0) {
        _hasTopic = YES;
    } else {
        _hasTopic = NO;
    }
    
    if (_startDate && _endDate && _hasTopic) {
        _payImage.image = [UIImage imageNamed:@"applePayHighlight"];
        _payLabel.textColor = AHYBlue;
    } else {
        _payLabel.textColor = AHYGrey28;
        _payImage.image = [UIImage imageNamed:@"applePay"];
    }
}

- (void)reviewAction
{
//    if (_startDate && _endDate && _hasTopic) {
        AHYReviewReservationVC *vc = [[AHYReviewReservationVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneAction
{
    
}

- (void)cancelBackAction
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    [[self navigationController].view.layer addAnimation:transition forKey:@"fadeTransition"];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)payReservationAction
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Come to pay!"
                                                        message:[NSString stringWithFormat:@"startTime:%@, endTime:%@, have topic:YES",_startDate,_endDate]
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
    [alertView show];
}

@end
