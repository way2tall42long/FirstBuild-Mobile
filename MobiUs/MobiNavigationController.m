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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"firstbuild-header-logo"]];
    [imageView setFrame:CGRectMake(0, 0, 40, 33)];
    CGPoint superCenter = CGPointMake(CGRectGetMidX(self.navigationBar.frame), CGRectGetMidY(self.navigationBar.frame));

    [imageView setCenter:superCenter];
    [self.navigationBar addSubview:imageView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
