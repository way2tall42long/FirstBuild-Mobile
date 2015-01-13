//
//  WifiCommissioningNetworkListViewController.h
//  MobiUs
//
//  Created by Myles Caley on 11/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTDevice.h"

@interface WifiCommissioningNetworkListViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView *networkListPickerView;
//@property (nonatomic, strong) NSArray *networks;
@property (strong, nonatomic) IBOutlet UITextField *passwordInput;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonRefreshNetworkList;
@property (strong, nonatomic) IBOutlet FSTDevice *device;
@end
