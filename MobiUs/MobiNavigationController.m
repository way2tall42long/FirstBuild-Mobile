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
    
    //self.navigationBar setBarTintColor:[UIColor colorWithRed:.3 green:.4 blue:.5 alpha:.2]
    //[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Orange-01.png"]
                             //forBarMetrics:UIBarMetricsDefault];
    //self.navigationBar.shadowImage = [UIImage imageNamed:@"Shadow2-02.png"];
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:241.0f/255.0f green:93.0f/255.0f blue:34.0f/255.0f alpha:1.0f]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
    
    [self.navigationBar setTitleTextAttributes: @{
                                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                                  NSFontAttributeName: [UIFont fontWithName:@"PTSans-NarrowBold" size:25.0f],
                                                 
                                                  }];
    //UINavigationBar* navigationBar = self.navigationBar;
    
    //[navigationBar setBarTintColor:[UIColor colorWithRed:0.0f green:0.0f blue:30.0f/255.0f alpha:0.3]];
    //[navigationBar setShadowImage:[UIImage imageNamed:@"OragneBar.png"]];
    
    //const CGFloat statusBarHeight = 20;    //  Make this dynamic in your own code...
    
    //UIView* underlayView = [[UIView alloc] initWithFrame:CGRectMake(0, -statusBarHeight, navigationBar.frame.size.width, navigationBar.frame.size.height + statusBarHeight)];
    //[underlayView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    //[underlayView setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:40.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    //[underlayView setAlpha:0.65f];
    //[navigationBar insertSubview:underlayView atIndex:1];
    
    
    
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
