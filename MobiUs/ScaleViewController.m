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
    
   
    //create a clipping mask in the shape of the path in the milk gallon
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = self.clippingView.clippingPath.CGPath  ;
    self.whiteView.layer.mask = mask;
    
    //create the view with the same dimensions as the clipping view, this will hold the "white" object which
    //will be clipped by the clipping bezier path. since we are drawing the "milk" from the bottom we need to reverse
    //the y origin and grow the box negative
    UIView * whiteFillView = [[UIView alloc]initWithFrame:CGRectMake(0, self.clippingView.bounds.size.height, self.clippingView.bounds.size.width, 0)];
    whiteFillView.backgroundColor = [UIColor whiteColor];
    [self.whiteView addSubview:whiteFillView];

    
    //create a wave view that sits on the top of the milk. we need to start that box just above the top of the milk
    //and the height should be the same proportion below it. the wave view centers the wave it draws.
    self.waveView = [[SCSiriWaveformView alloc]initWithFrame:CGRectMake(0, self.clippingView.bounds.size.height, self.clippingView.bounds.size.width, 24)];
    self.waveView.backgroundColor = [UIColor clearColor];
    [self.whiteView addSubview:self.waveView];
    
    //add it to the run loop for animation
    CADisplayLink *displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMeters)];
    [displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.waveView setWaveColor:[UIColor whiteColor]];
    
    [UIView animateWithDuration:1.2f animations:^{
        whiteFillView.frame =CGRectMake(0, self.clippingView.bounds.size.height, self.clippingView.bounds.size.width, -160);
        self.waveView.frame =CGRectMake(0, self.clippingView.bounds.size.height-172, self.clippingView.bounds.size.width, 24);
    } completion:^(BOOL finished) {
        //
    }];
}
- (void)updateMeters
{
    [self.waveView updateWithLevel:.5];
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
