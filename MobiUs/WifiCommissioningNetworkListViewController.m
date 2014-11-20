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

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://127.0.0.1:3001"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *networkMapping = [RKObjectMapping mappingForClass:[FSTNetwork class]];
    [networkMapping addAttributeMappingsFromArray:@[@"ssid"]];
    [networkMapping addAttributeMappingsFromArray:@[@"security_mode"]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:networkMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/networks"
                                                keyPath:@""
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (IBAction)buttonRefreshNetworksClick:(id)sender {
    [self loadNetworks];
}

- (IBAction)buttonCancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)loadNetworks
{

    [[RKObjectManager sharedManager] getObjectsAtPath:@"/networks"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _networks = mappingResult.array;
                                                  [_networkListPickerView reloadAllComponents];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [self performSegueWithIdentifier:@"segueError" sender:self];
                                              }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureRestKit];
    //[self loadNetworks];
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
