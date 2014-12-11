//
//  ProductAddViewController.m
//  MobiUs
//
//  Created by Myles Caley on 12/11/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "ProductAddViewController.h"
#import <SWRevealViewController.h>

@interface ProductAddViewController ()

@end

@implementation ProductAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.noProductsNoticeView setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.hasProducts)
    {
        [self.noProductsNoticeView setHidden:NO];
    }
}

- (IBAction)revealToggle:(id)sender {
         [self.revealViewController revealToggle:sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
