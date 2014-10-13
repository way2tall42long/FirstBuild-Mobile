//
//  LineCookViewController.m
//  MobiUs
//
//  Created by Myles Caley on 10/11/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "LineCookViewController.h"

@interface LineCookViewController ()

@end

@implementation LineCookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}


#pragma mark state preservation / restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    //
    //    // Save what you need here
    //    [coder encodeObject: _text forKey: @"text"];
    //    [coder encodeObject: _color forKey: @"color"];
    //
    //    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    //
    //    // Restore what you need here
    //    _color = [coder decodeObjectForKey: @"color"];
    //    _text = [coder decodeObjectForKey: @"text"];
    //
    //    [super decodeRestorableStateWithCoder:coder];
}

- (IBAction)revealToggle:(id)sender
{
    [self.revealViewController revealToggle:sender];
}

- (void)applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
}

@end
