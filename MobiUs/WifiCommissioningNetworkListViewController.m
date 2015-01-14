//
//  WifiCommissioningNetworkListViewController.m
//  MobiUs
//
//  Created by Myles Caley on 11/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "WifiCommissioningNetworkListViewController.h"
#import "WifiCommissioningConnectingViewController.h"
#import <RestKit.h>
#import "FSTNetwork.h"
#import "WifiCommissioningNetworksTableViewController.h"
#import "WifiCommissioningPasswordViewController.h"

@interface WifiCommissioningNetworkListViewController ()

@end

@implementation WifiCommissioningNetworkListViewController

- (IBAction)buttonCancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}
- (IBAction)buttonConnectClick:(id)sender {
    [self performSegueWithIdentifier:@"seguePassword" sender:self];
    
}
- (IBAction)refreshNetworkAction:(id)sender {
    WifiCommissioningNetworksTableViewController* listController = (WifiCommissioningNetworksTableViewController*)self.childViewControllers[0];
    [listController loadNetworks];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // intercept the segue to the embedded container controller
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"segueConnectingToChillHub"]) {
        [[RKObjectManager sharedManager] postObject:self.selectedNetwork path:@"/networks"
                                         parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                [self performSegueWithIdentifier:@"segueConnectingToChillHub" sender:self];
                                                
                                            }
                                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                [self performSegueWithIdentifier:@"segueErrorConnectingWifi" sender:self];
                                            }];
        WifiCommissioningConnectingViewController * connectingController = (WifiCommissioningConnectingViewController *) [segue destinationViewController];
        connectingController.device = self.device;
    }
    else if ([segueName isEqualToString:@"passwordSegue"])
    {
        WifiCommissioningPasswordViewController *connectingController = (WifiCommissioningPasswordViewController*) [segue destinationViewController];
        connectingController.network = self.selectedNetwork;
        connectingController.delegate = self;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self loadNetworks];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
