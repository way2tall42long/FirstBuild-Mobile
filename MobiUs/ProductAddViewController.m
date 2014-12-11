//
//  ProductAddViewController.m
//  MobiUs
//
//  Created by Myles Caley on 12/11/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "ProductAddViewController.h"
#import <SWRevealViewController.h>
#import <Firebase/Firebase.h>
#import "FirebaseShared.h"

@interface ProductAddViewController ()

@end

@implementation ProductAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.noProductsNoticeView setHidden:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    Firebase * ref = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"devices"];
    [ref observeSingleEventOfType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self.noProductsNoticeView setHidden:YES];
    }];
}

- (IBAction)revealToggle:(id)sender {
         [self.revealViewController revealToggle:sender];
}

@end
