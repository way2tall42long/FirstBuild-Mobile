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

- (void)loadNetworks
{
//    NSString *latLon = @"37.33,-122.03"; // approximate latLon of The Mothership (a.k.a Apple headquarters)
//    NSString *clientID = kCLIENTID;
//    NSString *clientSecret = kCLIENTSECRET;
//    
//    NSDictionary *queryParams = @{@"ll" : latLon,
//                                  @"client_id" : clientID,
//                                  @"client_secret" : clientSecret,
//                                  @"categoryId" : @"4bf58dd8d48988d1e0931735",
//                                  @"v" : @"20140118"};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/networks"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _networks = mappingResult.array;
                                                  [_networkListPickerView reloadAllComponents];
                                                  //[self.tableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _networkListPickerView.dataSource = self;
    _networkListPickerView.delegate = self;
    [self configureRestKit];
    [self loadNetworks];
    
    // Do any additional setup after loading the view.
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
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    textField.text = [dataArray objectAtIndex:row];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
