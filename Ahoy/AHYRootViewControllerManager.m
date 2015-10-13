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

@interface AHYRootViewControllerManager()

@property(nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AHYRootViewControllerManager

- (UIViewController *)rootViewController {
    UIViewController *tabVC1 = [[AHYDiscoverViewController alloc] init];
    tabVC1.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Discover"] selectedImage:[UIImage imageNamed:@"Discover"]];
    
    UIViewController *tabVC2 = [[AHYSearchViewController alloc] init];
    tabVC2.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Search"] selectedImage:[UIImage imageNamed:@"Search"]];
    
    //TODO replace with real instance
    UIViewController *tabVC3 = [[UIViewController alloc] init];
    tabVC3.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Chat"] selectedImage:[UIImage imageNamed:@"Chat"]];
    
    UIViewController *tabVC4 = [[UIViewController alloc] init];
    tabVC4.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"Profile"] selectedImage:[UIImage imageNamed:@"Profile"]];
    
    //for test
    tabVC1.view.backgroundColor = [UIColor redColor];
    tabVC2.view.backgroundColor = [UIColor yellowColor];
    tabVC3.view.backgroundColor = [UIColor blueColor];
    tabVC4.view.backgroundColor = [UIColor brownColor];
    
    self.tabBarController.viewControllers = @[tabVC1, tabVC2, tabVC3, tabVC4];
    return self.tabBarController;
}


- (UITabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[UITabBarController alloc] init];
    }
    return _tabBarController;
}

@end
