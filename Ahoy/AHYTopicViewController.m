//
//  AHYTopicViewController.m
//  Ahoy
//
//  Created by lichuanjun on 7/11/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

static NSString * const kAdvisorListCellIdentifier = @"advisorListCell";

#import "AHYTopicViewController.h"
#import "AHYAdvisor.h"
#import "AHYAdvisorListCell.h"
#import "AHYTopic.h"
#import "AHYAdVisorProfileVC.h"
#import "AHYAdvisorFilterView.h"
#import "Masonry.h"

@interface AHYTopicViewController ()<UIGestureRecognizerDelegate, AHYAdvisorFilterViewDelegate>

@property (nonatomic, strong) AHYTopic *topic;

@end

@implementation AHYTopicViewController

- (instancetype)initWithTopic:(AHYTopic *)topic {
    self = [super init];
    if (self) {
        _topic = topic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[AHYAdvisorListCell class] forCellReuseIdentifier:kAdvisorListCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = _topic.name;
    [self customNavigationBarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - actions

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)filterAdvisor {
    [[AHYAdvisorFilterView filterView] show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _topic.advisors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AHYAdvisorListCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdvisorListCellIdentifier forIndexPath:indexPath];
    [cell configure:_topic.advisors[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 138.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s:%@",__func__,self);
    
    AHYAdVisorProfileVC *vc = [[AHYAdVisorProfileVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom Navigation Bar Item

- (void)customNavigationBarItem {
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filterButton"] style:UIBarButtonItemStylePlain target:self action:@selector(filterAdvisor)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - AHYAdvisorFilterViewDelegate

- (void)cancelButtonDidPressed:(AHYAdvisorFilterView *)filterView {
    NSLog(@"%s:%@",__func__,self);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applyButtonDidPressed:(AHYAdvisorFilterView *)filterView {
    NSLog(@"%s:%@",__func__,self);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
