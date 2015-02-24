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
    
    self.logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_1b_orange_no_firstbuild"]];
    [self.logoView setFrame:CGRectMake(0, 0, 44, 26)];
    CGPoint superCenter = CGPointMake(CGRectGetMidX(self.navigationBar.frame), CGRectGetMidY(self.navigationBar.frame));

    [self.logoView setCenter:superCenter];
    [self.navigationBar addSubview:self.logoView];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x00B5CC)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    CGPoint superCenter = CGPointMake(size.width/2, self.navigationBar.frame.size.height/2);
    [self.logoView setCenter:superCenter];
}

@end
