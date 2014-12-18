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
#import "WifiCommissioningNetworkListViewController.h"

@interface WifiCommissioningViewController ()

@end

@implementation WifiCommissioningViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRestKit];
//    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1;
    scaleAnimation.repeatCount = HUGE_VAL;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:.4];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1 * 1 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VAL;
    
    //[self.searchingIcon.layer addAnimation:scaleAnimation forKey:@"scale"];
    [self.searchingIcon.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
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
    //the base url is set in AppDelegate for the shared instance of RestKit
    
    // networks GET|POST response
    RKObjectMapping *networkResponseMapping = [RKObjectMapping mappingForClass:[FSTNetwork class]];
    [networkResponseMapping addAttributeMappingsFromArray:@[@"ssid",@"security_mode",@"state",@"passphrase"]];
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:networkResponseMapping
                                                 method:RKRequestMethodAny
                                            pathPattern:@"/networks"
                                                keyPath:nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    
    // networks POST
    RKObjectMapping *networkRequestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [networkRequestMapping addAttributeMappingsFromArray:@[@"ssid",@"security_mode",@"state",@"passphrase"]];
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
                                            pathPattern:@"/"
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
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  self.device = mappingResult.array[0];
                                                  NSLog(@"UUID %@", self.device.uuid);
                                                  [self segueToNetworks];
                                                  //[self performSegueWithIdentifier:@"segueDisplayList" sender:self];
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
