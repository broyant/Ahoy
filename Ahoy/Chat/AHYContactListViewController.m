//
//  ContactListViewController.m
//  TestLeanCloud
//
//  Created by broyant on 16/1/21.
//  Copyright © 2016年 Ahoy. All rights reserved.
//

#import "AHYContactListViewController.h"
#import "AHYContactListCell.h"
#import "Masonry.h"
#import "OTRBuddy.h"

NSString * const kContactSearchPlaceHolder = @"Search For Topics Or Advisors…";
NSString * const kContactNoResultsTips = @"You can search topics, or search advisors by their names, companies, positions and their offerings for different topics.";

@interface AHYContactListViewController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate,UISearchBarDelegate>
{
    UIBarButtonItem *_rightBarItem;
    
    UITableView *_contactListTableView;
    

    
    //search HeaderView;
    UIView *_headerView;
    UISearchBar *_searchBar;
    UIButton *_cancelButton;
    
    UIView *_searchContainerView;
    UITableView *_searchResultTableView;

    NSString *_searchKeyword;

    
}

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *searchResultDataSource;

@end

@implementation AHYContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.edgesForExtendedLayout = UIRectEdgeBottom;
//    self.title = @"Chat";
    self.navigationItem.title = @"CHATS";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.f, 0.f, 14.f, 14.f);
    [button setImage:[UIImage imageNamed:@"chat_search"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    _rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];

//    _rightBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarItemPress:)];
    self.navigationItem.rightBarButtonItem = _rightBarItem;
    
    [self setupContactListTableView];
    
    [self setupSearchDisplayView];
    
}

- (void)searchBarItemPress:(UIBarButtonItem *)sender {
    NSLog(@"search bar item press.");
    [self showSearchView];
}

- (void)cancelSearchButtonPressed {
    self.title = @"Chat";
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem = _rightBarItem;
    [self.searchResultDataSource removeAllObjects];
    [_searchResultTableView reloadData];
    _searchContainerView.hidden = YES;
    _searchKeyword = @"";
}

- (void)showSearchView {
    self.navigationItem.rightBarButtonItem = nil;
    
    static CGFloat kLeftRightMarginBySystem = 8.f;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, 44.f)];
    _headerView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _headerView;
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headerView addSubview:_cancelButton];
    _cancelButton.backgroundColor = [UIColor clearColor];
    [_cancelButton setTitleColor:AHYWhite forState:UIControlStateNormal];
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font =TradeGothicLT(16);
    
    [_cancelButton addTarget:self action:@selector(cancelSearchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(_headerView.mas_trailing).with.offset(-14 + kLeftRightMarginBySystem);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(19);
        make.centerY.mas_equalTo(_headerView.mas_centerY);
    }];
    
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"Search For Chat";

    [_headerView addSubview:_searchBar];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30.f);
        make.bottom.equalTo(_headerView.mas_bottom).with.offset(-6);
        make.leading.equalTo(_headerView).offset(15.f-kLeftRightMarginBySystem);
        make.trailing.equalTo(_cancelButton.mas_leading).with.offset(-11);

    }];
    
    _searchContainerView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupContactListTableView {
    _contactListTableView = [[UITableView alloc] init];
    _contactListTableView.backgroundColor = [UIColor clearColor];
    _contactListTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _contactListTableView.accessibilityIdentifier = @"contactsTableView";
    _contactListTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _contactListTableView.delegate = self;
    _contactListTableView.dataSource = self;
    _contactListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contactListTableView.rowHeight = kAHYContactListTableCellHeight;
    [self.view addSubview:_contactListTableView];
    [_contactListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

- (void)setupSearchDisplayView {
    _searchContainerView = [[UIView alloc] init];
    [self.view addSubview:_searchContainerView];
    _searchContainerView.hidden = YES;
    _searchContainerView.backgroundColor = [UIColor clearColor];
    [_searchContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    

    _searchResultTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _searchResultTableView.backgroundColor = [UIColor clearColor];
    _searchResultTableView.accessibilityIdentifier = @"contactSearchTableView";
    _searchResultTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _searchResultTableView.delegate = self;
    _searchResultTableView.dataSource = self;
    _searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchResultTableView.rowHeight = kAHYContactListTableCellHeight;
    [_searchContainerView addSubview:_searchResultTableView];
    [_searchResultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_searchContainerView);
    }];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectViewBG = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    [_searchContainerView addSubview:visualEffectViewBG];

    [_searchContainerView insertSubview:visualEffectViewBG belowSubview:_searchResultTableView];
    [visualEffectViewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_searchContainerView);
    }];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    [_dataSource removeAllObjects];
    BOOL debug = YES;
    if (debug) {
        for (int idx = 0; idx < 10; ++idx) {
            OTRBuddy *buddy = [[OTRBuddy alloc] initWithUniqueId:[NSString stringWithFormat:@"id_%d",idx]];
            buddy.displayName = [NSString stringWithFormat:@"displayName_%d",idx];
            if (idx == 4 || idx == 5) {
                buddy.displayName = [NSString stringWithFormat:@"long long long displayName_%d",idx];
            }
            NSDate *curDate = [NSDate date];

            buddy.lastMessageDate =  [curDate dateByAddingTimeInterval:-((idx+1) * 3600 *24)];
            
            NSArray *companys = @[@"Google",@"Facebook",@"Microsoft",@"Amazon",@"Alibaba"];
            NSArray *topics = @[@"How to be Strong?",@"American Movie",@"American Music",@"Chinese Culture",@"Chinese long long long long long long long history"];
            
            buddy.extraInfoAttr = @{@"ahy_company":companys[idx%5],@"ahy_topic":topics[idx%5]};
            
            [_dataSource addObject:buddy];

        }
    }
    
    return _dataSource;
}

- (NSMutableArray *)searchResultDataSource {
    if (!_searchResultDataSource) {
        _searchResultDataSource = [NSMutableArray array];
    }
    return _searchResultDataSource;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _contactListTableView) {
        return [self.dataSource count];
    }
    else {
        return [self.searchResultDataSource count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AHYContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:[AHYContactListCell reuseIdentifier]];
    if (!cell) {
        cell = [[AHYContactListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[AHYContactListCell reuseIdentifier]];
        NSMutableArray *rightUtilityButtons = [NSMutableArray array];
        [rightUtilityButtons sw_addUtilityButtonWithColor:AHYYellow title:@"REVIEW"];
        [rightUtilityButtons sw_addUtilityButtonWithColor:AHYRed title:@"DELETE"];
        [cell setRightUtilityButtons:rightUtilityButtons WithButtonWidth:85.f];
    }
    
    cell.delegate = self;
    OTRBuddy *buddy = nil;
    if (tableView == _contactListTableView) {
        buddy = [self.dataSource objectAtIndex:indexPath.row];
        [cell configureWithOTRBuddy:buddy keyword:nil];
    }
    else{
        buddy = [self.searchResultDataSource objectAtIndex:indexPath.row];
        NSString *keyword = [_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [cell configureWithOTRBuddy:buddy keyword:keyword];
    }

    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAHYContactListTableCellHeight;
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state {
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"check button was pressed");
            break;
        case 1:
            NSLog(@"clock button was pressed");
            break;
        case 2:
            NSLog(@"cross button was pressed");
            break;
        case 3:
            NSLog(@"list button was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"More button was pressed");
            break;
        case 1:
        {
            // Delete button was pressed
            NSLog(@"Delete button was pressed");
            
            NSIndexPath *indexPath = [_contactListTableView indexPathForCell:cell];
            
            if (indexPath)
            {
                NSLog(@"Do some database thing here.");
                
                /*
                 __block OTRBuddy *cellBuddy = [[self buddyForIndexPath:indexPath] copy];
                 
                 [[GNDatabaseManager sharedInstance].readWriteDatabaseConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
                 [cellBuddy removeWithTransaction:transaction];
                 } completionBlock:^{
                 
                 //                    [[ChatMediaFileManager sharedInstance] deleteMediaFileOfBuddy:cellBuddy.uniqueId completion:^(BOOL successed, NSError *error) {
                 //
                 //                        if (error) {
                 //
                 //                            DLog(@"removeMessageFile fail:%@",error);
                 //                        }
                 //                        if (successed) {
                 //                            DLog(@"removeMessageFile successed");
                 //
                 //                        }
                 //
                 //                    } completionQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
                 }];
                 */
            }
            
            
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}

- (void)didTriggerSearchWithKeyword:(NSString *)keyword {
    [_searchResultDataSource removeAllObjects];
    
    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    keyword = [keyword lowercaseString];
    if (keyword.length > 0)
    {
        
        for (int idx = 0; idx < self.dataSource.count; ++idx) {
            OTRBuddy *buddy = [self.dataSource objectAtIndex:idx];
            

            NSString *buddyName = [buddy.displayName lowercaseString];
            NSString *topic = [[buddy.extraInfoAttr valueForKey:@"ahy_topic"] lowercaseString];
            NSString *buddyID = [buddy.uniqueId lowercaseString];
            
            if ([buddyName containsString:keyword] || [topic containsString:keyword] || [buddyID containsString:keyword])
            {
                if (![self.searchResultDataSource containsObject:buddy]) {
                    [self.searchResultDataSource addObject:buddy];
                }
            }
        }
        
    }
    [_searchResultTableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _searchKeyword = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (_searchKeyword.length > 0) {
        [self didTriggerSearchWithKeyword:_searchKeyword];
        [searchBar resignFirstResponder];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
