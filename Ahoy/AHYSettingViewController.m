//
//  AHYSettingViewController.m
//  Ahoy
//
//  Created by lichuanjun on 17/1/2016.
//  Copyright © 2016 Ahoy. All rights reserved.
//

#import "AHYSettingViewController.h"
#import "AHYSettingTableViewCell.h"
#import <Masonry.h>

@interface AHYSettingViewController ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *items;

@end

@implementation AHYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MORE";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.tableView.tableFooterView = [self footerView];
    [self.tableView registerNib:[UINib nibWithNibName:@"AHYSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"settingCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.items[section] valueForKey:@"title"] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 30)];
    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, CGRectGetWidth(tableView.frame), 18)];
    sectionTitle.font = TradeGothicLTBoldTwo(14);
    sectionTitle.textColor = AHYGrey40;
    sectionTitle.textAlignment = NSTextAlignmentLeft;
    sectionTitle.text = self.sections[section];
    
    [view addSubview:sectionTitle];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AHYSettingTableViewCell *cell = (AHYSettingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    NSArray *images = [self.items[indexPath.section] valueForKey:@"image"];
    NSArray *titles = [self.items[indexPath.section] valueForKey:@"title"];
    
    cell.imgView.image = [UIImage imageNamed:images[indexPath.row]];
    cell.titleLabel.text = titles[indexPath.row];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark -private

- (NSArray *)items {
    if (!_items) {
        _items = @[@{@"title": @[@"Orders & Reservations", @"Wish List", @"Free Sessions"],
                     @"image": @[@"orderHistoryCopy", @"shape", @"shareButton"]},
                   @{@"title": @[@"Card Ending in 0303", @"Add A New Card"],
                     @"image": @[@"visaBadge", @"addANewCard"]},
                   @{@"title": @[@"Notifications", @"Account Info"],
                     @"image": @[@"notifications", @"account"]},
                   @{@"title": @[@"Send Feedback", @"Help Center", @"Terms & Privacy"],
                     @"image": @[@"ahoyFeedback", @"help", @"terms"]}
                   ];
    }
    return _items;
}

- (NSArray *)sections {
    if (!_sections) {
        _sections = @[@"GERNAL", @"PAYMENT OPTIONS", @"SETTINGS", @"MISCELLANEOUS"];
    }
    return _sections;
}

- (UIView *)footerView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 180)];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ahoy"]];
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.textColor = AHYSteelGrey;
    versionLabel.font = AvenirNextRegular(14);
    versionLabel.text = [@"Version:" stringByAppendingString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setTitle:@"logout" forState:UIControlStateNormal];
    logoutButton.layer.borderColor = AHYRed.CGColor;
    logoutButton.layer.borderWidth = 1.0f;
    logoutButton.layer.cornerRadius = 1.0f;
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logoutButton setTitleColor:AHYRed forState:UIControlStateNormal];
    
    [view addSubview:logoView];
    [view addSubview:versionLabel];
    [view addSubview:logoutButton];
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_offset(30);
    }];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(logoView.mas_bottom).mas_offset(5);
    }];
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(versionLabel.mas_bottom).mas_offset(20);
        make.width.mas_equalTo(345);
        make.height.mas_equalTo(40);
    }];
    
    return view;
}

- (void)logout {

}

@end
