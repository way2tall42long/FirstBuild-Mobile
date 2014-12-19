//
//  ChillHubDevicesTableViewController.h
//  MobiUs
//
//  Created by Myles Caley on 12/18/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTChillHubDevice.h"

@interface ChillHubDevicesTableViewController : UITableViewController
@property (strong, nonatomic) FSTChillHubDevice * chillhub;
@end
