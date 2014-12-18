//
//  WifiCommissioningViewController.h
//  MobiUs
//
//  Created by Myles Caley on 11/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTDevice.h"

@interface WifiCommissioningViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *searchingIcon;
@property NSInteger checkForAPTries;
@property (strong, nonatomic) IBOutlet FSTDevice *device;
@end
