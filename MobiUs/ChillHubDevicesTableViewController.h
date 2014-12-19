//
//  ChillHubDevicesTableViewController.h
//  MobiUs
//
//  Created by Myles Caley on 12/18/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTChillHub.h"

@interface ChillHubDevicesTableViewController : UITableViewController
@property (strong, nonatomic) FSTChillHub * chillhub;
@property (strong, nonatomic) NSMutableArray *products;
@property (nonatomic) BOOL haveFirebaseBinding;
@end
