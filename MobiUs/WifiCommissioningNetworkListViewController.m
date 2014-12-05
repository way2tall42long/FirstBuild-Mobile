//
//  WifiCommissioningNetworkListViewController.m
//  MobiUs
//
//  Created by Myles Caley on 11/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "WifiCommissioningNetworkListViewController.h"
#import <RestKit.h>
#import "FSTNetwork.h"

@interface WifiCommissioningNetworkListViewController ()

@end

@implementation WifiCommissioningNetworkListViewController

- (IBAction)buttonRefreshNetworksClick:(id)sender {
    [self loadNetworks];
}

- (IBAction)buttonCancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}
- (IBAction)buttonConnectClick:(id)sender {
    NSInteger row;
    FSTNetwork* networkToJoin = [FSTNetwork new];
    
    row = [self.networkListPickerView selectedRowInComponent:0];
    networkToJoin= [self.networks objectAtIndex:row];
    networkToJoin.state = @"client";
    networkToJoin.passphrase = self.passwordInput.text;
    [[RKObjectManager sharedManager] postObject:networkToJoin path:@"/networks"
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            [self performSegueWithIdentifier:@"segueConnectingToChillHub" sender:self];

                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            [self performSegueWithIdentifier:@"segueErrorConnectingWifi" sender:self];
                                        }];
}

- (void)loadNetworks
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/networks"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _networks = mappingResult.array;
                                                  [_networkListPickerView reloadAllComponents];
                                                  if (_networks.count==0)
                                                  {
                                                      [self performSegueWithIdentifier:@"segueErrorNetworks" sender:self];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [self performSegueWithIdentifier:@"segueErrorNetworks" sender:self];
                                              }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadNetworks];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == _networkListPickerView)
    {
        FSTNetwork *network = _networks[row];
        return network.ssid;
    }
    return @"";
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == _networkListPickerView)
    {
        return [_networks count];
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


@end
