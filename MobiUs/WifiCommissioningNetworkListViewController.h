//
//  WifiCommissioningNetworkListViewController.h
//  MobiUs
//
//  Created by Myles Caley on 11/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTDevice.h"
#import "FSTNetwork.h"

@interface WifiCommissioningNetworkListViewController : UIViewController
@property (strong, nonatomic) FSTDevice *device; 
@property (strong, nonatomic) FSTNetwork* selectedNetwork;
@end
