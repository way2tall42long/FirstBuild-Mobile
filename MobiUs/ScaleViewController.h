//
//  ScaleViewController.h
//  MobiUs
//
//  Created by Myles Caley on 10/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STKSpinnerView.h"
#import "FSTMilkyWeigh.h"

@interface ScaleViewController : UIViewController
@property (strong, nonatomic) IBOutlet STKSpinnerView *spinnerView;
@property (strong, nonatomic) FSTMilkyWeigh *milkyWeigh;
@end
