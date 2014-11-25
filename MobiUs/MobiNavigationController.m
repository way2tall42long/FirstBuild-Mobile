//
//  MobiNavigationController.m
//  MobiUs
//
//  Created by David Calvert on 10/6/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "MobiNavigationController.h"

@interface MobiNavigationController ()

@end

@implementation MobiNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Orange-01.png"]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage imageNamed:@"shadow3.png"];
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
    
    [self.navigationBar setTitleTextAttributes: @{
                                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                                  NSFontAttributeName: [UIFont fontWithName:@"PTSans-NarrowBold" size:25.0f],
                                                 
                                                  }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
