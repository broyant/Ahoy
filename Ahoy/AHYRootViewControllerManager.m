//
//  AHYRootViewControllerManager.m
//  Ahoy
//
//  Created by lichuanjun on 12/10/15.
//  Copyright © 2015 Ahoy. All rights reserved.
//

#import "AHYRootViewControllerManager.h"
#import "AHYDiscoverViewController.h"
#import "AHYSearchViewController.h"
#import "AHYProfileViewController.h"

@interface AHYRootViewControllerManager()

@property(nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AHYRootViewControllerManager

- (UIViewController *)rootViewController {    
    AHYDiscoverViewController *discoverVC = [[AHYDiscoverViewController alloc] init];
    UINavigationController *tabVC1 = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    tabVC1.navigationBar.barTintColor = AHYBlue;
    [tabVC1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: AHYWhite}];
    tabVC1.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Discover"] selectedImage:[UIImage imageNamed:@"Discover"]];
    
    AHYSearchViewController *searchVC = [[AHYSearchViewController alloc] init];
    UINavigationController *tabVC2 = [[UINavigationController alloc] initWithRootViewController:searchVC];
    tabVC2.navigationBar.barTintColor = AHYBlue;
    tabVC2.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Search"] selectedImage:[UIImage imageNamed:@"Search"]];
    
    //TODO replace with real instance
    UIViewController *tabVC3 = [[UIViewController alloc] init];
    tabVC3.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Chat"] selectedImage:[UIImage imageNamed:@"Chat"]];
    
    AHYProfileViewController *tabVC4 = [AHYProfileViewController getInstance];
    tabVC4.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Profile"] selectedImage:[UIImage imageNamed:@"Profile"]];
    
    
    self.tabBarController.viewControllers = @[tabVC1, tabVC2, tabVC3, tabVC4];
    //remove title and make image center
    for (UITabBarItem *tabBarItem in self.tabBarController.tabBar.items) {
        tabBarItem.title = @"";
        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self.tabBarController;
}


- (UITabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[UITabBarController alloc] init];
    }
    return _tabBarController;
}

@end
