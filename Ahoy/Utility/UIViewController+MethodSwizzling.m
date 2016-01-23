//
//  UIViewController+MethodSwizzling.m
//  Ahoy
//
//  Created by lichuanjun on 21/1/2016.
//  Copyright © 2016 Ahoy. All rights reserved.
//

#import "UIViewController+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (MethodSwizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            Method originMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
            Method swizzledMethod = class_getInstanceMethod([self class], @selector(ahy_viewDidLoad));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (void)ahy_viewDidLoad {
    //if self is not the topVC in navigationController stack, set the custom back barButtonItem
    if (self.navigationController !=nil && self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = AHYBlue;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: AHYWhite,NSFontAttributeName:TradeGothicLTBold(18)}];

    [self ahy_viewDidLoad];
}

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
