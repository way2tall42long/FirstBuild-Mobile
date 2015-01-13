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
    
    //add the custom logo at the top. using a subview unfortunately because I spent
    //way too much time screwing around with titleView, which centers automagically between
    //the leftbarbutton item and right
    self.logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_1b_orange_no_firstbuild"]];
    [self.logoView setFrame:CGRectMake(0, 0, 44, 26)];
    CGPoint superCenter = CGPointMake(CGRectGetMidX(self.navigationBar.frame), CGRectGetMidY(self.navigationBar.frame));

    [self.logoView setCenter:superCenter];
    [self.navigationBar addSubview:self.logoView];
    //self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x00B5CC)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
