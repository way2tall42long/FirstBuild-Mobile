//
//  WifiCommissioningErrorViewController.m
//  MobiUs
//
//  Created by Myles Caley on 11/20/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "WifiCommissioningErrorViewController.h"

@interface WifiCommissioningErrorViewController ()

@end

@implementation WifiCommissioningErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)buttonCancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

@end
