//
//  WifiCommissioningConnectingViewController.m
//  MobiUs
//
//  Created by Myles Caley on 12/18/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "WifiCommissioningConnectingViewController.h"
#import "FSTDevice.h"
#import "FirebaseShared.h"
#import <Firebase/Firebase.h>

@interface WifiCommissioningConnectingViewController ()

@end

@implementation WifiCommissioningConnectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Firebase *addRef = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"devices/chillhubs"];
    [addRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        //NSLOG(@"UUID )
//        [self.products addObject:chillhub];
//        [self.productCollection reloadData];
//         [self.navigationController popViewControllerAnimated:YES];
    }];
   
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
