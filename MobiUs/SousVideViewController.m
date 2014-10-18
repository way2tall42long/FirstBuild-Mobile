//
//  SousVideViewController.m
//  MobiUs
//
//  Created by Myles Caley on 10/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "SousVideViewController.h"
#import <SWRevealViewController.h>

@implementation SousVideViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)revealToggle:(id)sender
{
    [self.revealViewController revealToggle:sender];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}
@end
