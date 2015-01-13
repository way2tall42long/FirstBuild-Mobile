//
//  WifiCommissioningPasswordViewController.m
//  MobiUs
//
//  Created by Myles Caley on 1/12/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "WifiCommissioningPasswordViewController.h"

@interface WifiCommissioningPasswordViewController ()

@end

@implementation WifiCommissioningPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, self.view.bounds.size.width-60, self.view.bounds.size.height-60)];
    //passwordView.backgroundColor = [UIColor redColor];
    UIToolbar *translucentUnderlayment = [[UIToolbar alloc] init];
    [translucentUnderlayment setFrame:self.view.bounds];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [translucentUnderlayment setAlpha:0.9];
    }
    translucentUnderlayment.layer.masksToBounds = YES;
    [self.view addSubview:translucentUnderlayment];
    
   // [self.view addSubview:passwordView];
    // Do any additional setup after loading the view.
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

@end
