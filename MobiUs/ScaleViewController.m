//
//  ScaleViewController.m
//  MobiUs
//
//  Created by Myles Caley on 10/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "ScaleViewController.h"
#import "FirebaseShared.h"
#import <Firebase/Firebase.h>


@implementation ScaleViewController

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMilkJug
{
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = self.clippingView.clippingPath.CGPath  ;
    self.whiteView.layer.mask = mask;
    UIView * whiteFillView = [[UIView alloc]initWithFrame:CGRectMake(0, self.clippingView.bounds.size.height, 1000, -150)];
    whiteFillView.backgroundColor = [UIColor whiteColor];
    [self.whiteView addSubview:whiteFillView];
}

- (void)viewDidLoad
{
    //TODO: cleanup references
    [super viewDidLoad];
   
    
    [self.milkyWeigh.firebaseRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        id rawVal = snapshot.value;
        if (rawVal != [NSNull null])
        {
            NSDictionary* val = rawVal;
            float percentageLeft = [(NSNumber *)[val objectForKey:@"weight"] doubleValue]/100;
            [self loadMilkJug];
            //self.emptyClippingMask
            //[[self spinnerView] setProgress:percentageLeft animated:YES];
        }
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    
}

@end
