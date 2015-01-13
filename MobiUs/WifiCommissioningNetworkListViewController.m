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
//    NSInteger row;
//    FSTNetwork* networkToJoin = [FSTNetwork new];
//    
//    row = [self.networkListPickerView selectedRowInComponent:0];
//    networkToJoin= [self.networks objectAtIndex:row];
//    networkToJoin.state = @"client";
//    networkToJoin.passphrase = self.passwordInput.text;
//    [[RKObjectManager sharedManager] postObject:networkToJoin path:@"/networks"
//                                     parameters:nil
//                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                            [self performSegueWithIdentifier:@"segueConnectingToChillHub" sender:self];
//
//                                        }
//                                        failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                                            [self performSegueWithIdentifier:@"segueErrorConnectingWifi" sender:self];
//                                        }];
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
        WifiCommissioningConnectingViewController * connectingController = (WifiCommissioningConnectingViewController *) [segue destinationViewController];
        connectingController.device = self.device;
    }
//    } else if ([segueName isEqualToString:@"embeddedListSegue"])
//    {
//        WifiCommissioningNetworksTableViewController *connectingController = (WifiCommissioningNetworksTableViewController*) [segue destinationViewController];
//        
//    }
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



//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if (pickerView == _networkListPickerView)
//    {
////        FSTNetwork *network = _networks[row];
//        return network.ssid;
//    }
//    return @"";
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    if(pickerView == _networkListPickerView)
//    {
////        FSTNetwork *network = _networks[row];
//    }
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    if (pickerView == _networkListPickerView)
//    {
////        return [_networks count];
//    }
//    return 0;
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//

@end
