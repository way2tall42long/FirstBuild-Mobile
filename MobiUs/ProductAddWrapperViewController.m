//
//  ProductAddWrapperViewController.m
//  MobiUs
//
//  Created by Myles Caley on 1/8/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "ProductAddWrapperViewController.h"
#import "UILabel+MultiLineAutoSize.h"
#import <SWRevealViewController.h>

@interface ProductAddWrapperViewController ()

@end

@implementation ProductAddWrapperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.lblHeader adjustFontSizeToFitMultiLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)revealButtonClick:(id)sender {
    
    [self.revealViewController rightRevealToggle:sender];
}

@end
