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
    // Do any additional setup after loading the view.
    
   
    self.navigationBar.backgroundColor = [UIColor colorWithHue:.3 saturation:.4 brightness:.5 alpha:.1];
    self.navigationBar.alpha = .6f;
    self.navigationBar.translucent = YES;
    
    
    

    
    
    

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
