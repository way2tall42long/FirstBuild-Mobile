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
#import "FSTToken.h"
#import "FSTDevice.h"
#import "FBTUser.h"
#import "MobiNavigationController.h"
#import "WifiCommissioningNetworkListViewController.h"

@interface WifiCommissioningViewController ()

@end

@implementation WifiCommissioningViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRestKit];

    NSMutableArray *imgListArray = [NSMutableArray array];
    for (int i=11; i <= 33; i++) {
        NSString *strImgeName = [NSString stringWithFormat:@"pulsing rings_%05d.png", i];
        UIImage *image = [UIImage imageNamed:strImgeName];
        if (!image) {
            NSLog(@"Could not load image named: %@", strImgeName);
        }
        else {
            [imgListArray addObject:image];
        }
    }
    
    [self.searchingIcon setAnimationImages:imgListArray];
    [self.searchingIcon setAnimationDuration:.75];
    [self.searchingIcon startAnimating];
    
    MobiNavigationController* nav = (MobiNavigationController*)self.navigationController;
    nav.logoView.hidden = YES;
    
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
    //the base url is set in AppDelegate for the shared instance of RestKit
    
    // networks GET|POST response
    RKObjectMapping *networkResponseMapping = [RKObjectMapping mappingForClass:[FSTNetwork class]];
    [networkResponseMapping addAttributeMappingsFromArray:@[@"ssid",@"passphrase"]];
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:networkResponseMapping
                                                 method:RKRequestMethodAny
                                            pathPattern:@"/networks"
                                                keyPath:nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    
    // networks POST
    RKObjectMapping *networkRequestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [networkRequestMapping addAttributeMappingsFromArray:@[@"ssid",@"passphrase"]];
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor
                                              requestDescriptorWithMapping:networkRequestMapping
                                              objectClass:[FSTNetwork class]
                                              rootKeyPath:nil
                                              method:RKRequestMethodPOST];
    
    // token POST request
    RKObjectMapping *tokenRequestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [tokenRequestMapping addAttributeMappingsFromArray:@[@"token"]];
    RKRequestDescriptor *tokenRequestDescriptor = [RKRequestDescriptor
                                              requestDescriptorWithMapping:tokenRequestMapping
                                              objectClass:[FSTToken class]
                                              rootKeyPath:nil
                                              method:RKRequestMethodPOST];
    
    // token POST response
    RKObjectMapping *tokenResponseMapping = [RKObjectMapping mappingForClass:[FSTToken class]];
    [tokenResponseMapping addAttributeMappingsFromArray:@[@"token"]];
    RKResponseDescriptor *tokenResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:networkResponseMapping
                                                 method:RKRequestMethodAny
                                            pathPattern:@"/token"
                                                keyPath:nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // device GET
    RKObjectMapping *deviceResponseMapping = [RKObjectMapping mappingForClass:[FSTDevice class]];
    [deviceResponseMapping addAttributeMappingsFromArray:@[@"uuid"]];
    RKResponseDescriptor *deviceResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:deviceResponseMapping
                                                 method:RKRequestMethodAny
                                            pathPattern:@"/root"
                                                keyPath:nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    [[RKObjectManager sharedManager] addResponseDescriptor:deviceResponseDescriptor];
    [[RKObjectManager sharedManager] addRequestDescriptor:requestDescriptor];
    [[RKObjectManager sharedManager] addRequestDescriptor:tokenRequestDescriptor];
    [[RKObjectManager sharedManager] addResponseDescriptor:tokenResponseDescriptor];

}


- (void)checkForConnectivity
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/root"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  self.device = mappingResult.array[0];
                                                  NSLog(@"UUID %@", self.device.uuid);
                                                  [self segueToNetworks];
                                                  //[self performSegueWithIdentifier:@"segueDisplayList" sender:self];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  //try again
                                                  if (self.checkForAPTries < 3)
                                                  {
                                                      
                                                      NSLog(@"attempting search again...");
                                                      self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:3.0
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

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchTimer invalidate];
    self.searchTimer = nil;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // intercept the segue to the embedded container controller
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"segueDisplayList"]) {
        WifiCommissioningNetworkListViewController * networkController = (WifiCommissioningNetworkListViewController *) [segue destinationViewController];
        networkController.device = self.device;
    }
}

- (void)segueToNetworks
{
    FSTToken* token = [FSTToken new];
    FBTUser *user = [FBTUser sharedInstance];
    
    token.token = user.token;
    
    [[RKObjectManager sharedManager] postObject:token path:@"/token"
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            [self performSegueWithIdentifier:@"segueDisplayList" sender:self];
                                            
                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            //TODO: need appropriate segue
                                            [self performSegueWithIdentifier:@"segueSearchTimeout" sender:self];
                                        }];
}

@end
