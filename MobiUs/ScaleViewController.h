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
#import "MilkGallonClippingView.h"

@interface ScaleViewController : UIViewController

@property (strong, nonatomic) FSTMilkyWeigh *milkyWeigh;
@property (strong, nonatomic) IBOutlet UIImageView *milkJugView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *whiteView; //view that lays in the white behind the jug
@property (strong, nonatomic) IBOutlet MilkGallonClippingView *clippingView; //view that draws and clips the white view

@end
