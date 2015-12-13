//
//  AHYSearchViewController.m
//  Ahoy
//
//  Created by lichuanjun on 13/10/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

static NSString * const kSearchPlaceHolder = @"Search For Topics Or Advisors…";
static NSString * const kNoResultsTips = @"You can search topics, or search advisors by their names, companies, positions and their offerings for different topics.";
static NSString * const kCellIdentifier = @"searchList";

#import "AHYSearchViewController.h"
#import "AHYSearchResultsViewController.h"
#import "AHYTopic.h"
#import <Masonry.h>

@interface AHYSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate>

@property (nonatomic, strong) NSArray *historyRecords;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *noResultView;
@property (nonatomic, strong) NSArray *recommendTopics;
@property (nonatomic, strong) NSArray *sections;

@end

@implementation AHYSearchViewController

- (NSArray *)recommendTopics {
    if (!_recommendTopics) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            NSString *topic = [NSString stringWithFormat:@"Computer_%d", i];
            [array addObject:topic];
        }
        _recommendTopics = [array copy];
    }
    return _recommendTopics;
}

- (NSArray *)historyRecords {
    // read from file
    return @[@"computer", @"hello"];
}

- (NSArray *)sections {
    if (self.historyRecords.count) {
        return @[self.historyRecords, self.recommendTopics];
    } else {
        return @[self.recommendTopics];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self configureNoResultsView];
    [self configureTableView];
    [self configureSearchController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - configure 

- (void)configureTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)configureNoResultsView {
    _noResultView = [[UILabel alloc] init];
    _noResultView.textColor = AHYGrey40;
    _noResultView.font = TradeGothicLT(16);
    _noResultView.numberOfLines = 0;
    _noResultView.text = kNoResultsTips;
    _noResultView.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_noResultView];
    [_noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_greaterThanOrEqualTo(20);
        make.center.equalTo(self.view);
    }];
}

- (void)configureSearchController {
    AHYSearchResultsViewController *searchResultVC = [[AHYSearchResultsViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchResultsUpdater = searchResultVC;
    _searchController.searchBar.delegate = searchResultVC;
    _searchController.searchBar.placeholder = kSearchPlaceHolder;
    _searchController.searchBar.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = _searchController.searchBar;
}

#pragma mark - tableView delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sections[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.historyRecords.count) {
        if (section == 0) {
            return @"Recent Searches";
        }else{
        return @"Popular Topics";
        }
    } else {
       return @"Popular Topics";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.font = TradeGothicLTBold(20);
    cell.textLabel.text = self.sections[indexPath.section][indexPath.row];
    return cell;
}

@end
