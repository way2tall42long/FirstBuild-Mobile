//
//  WifiCommissioningViewController.m
//  MobiUs
//
//  Created by Myles Caley on 11/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "WifiCommissioningViewController.h"
#import <RestKit.h>
#import "FSTNetwork.h"

@interface WifiCommissioningViewController ()

@end

@implementation WifiCommissioningViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRestKit];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.checkForAPTries = 0;
    [self checkForConnectivity];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRestKit
{
    RKObjectMapping *networkResponseMapping = [RKObjectMapping mappingForClass:[FSTNetwork class]];
    [networkResponseMapping addAttributeMappingsFromArray:@[@"ssid",@"security_mode",@"state"]];
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:networkResponseMapping
                                                 method:RKRequestMethodAny
                                            pathPattern:@"/networks"
                                                keyPath:nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    RKObjectMapping *networkRequestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [networkRequestMapping addAttributeMappingsFromArray:@[@"ssid",@"security_mode",@"state"]];
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor
                                              requestDescriptorWithMapping:networkRequestMapping
                                              objectClass:[FSTNetwork class]
                                              rootKeyPath:nil
                                              method:RKRequestMethodPOST];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    [[RKObjectManager sharedManager] addRequestDescriptor:requestDescriptor];

}


- (void)checkForConnectivity
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/networks"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self performSegueWithIdentifier:@"segueDisplayList" sender:self];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  //try again
                                                  if (self.checkForAPTries < 5)
                                                  {
                                                      NSLog(@"attempting search again...");
                                                      [NSTimer scheduledTimerWithTimeInterval:3.0
                                                                                       target:self
                                                                                     selector:@selector(checkForConnectivity)
                                                                                     userInfo:nil
                                                                                      repeats:NO];
                                                  }
                                                  else
                                                  {
                                                      [self performSegueWithIdentifier:@"segueSearchTimeout" sender:self];
                                                  }
                                                  self.checkForAPTries++;
                                              }];
}

@end
