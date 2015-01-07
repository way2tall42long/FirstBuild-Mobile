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

@implementation UIView (ScaleViewController)

- (void)centerizeInWidth:(CGFloat)width
{
    self.frame = CGRectMake((width - self.frame.size.width)/2.0,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}
@end

@implementation ScaleViewController

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    //TODO: cleanup references
    [super viewDidLoad];
    UIColor* strokeColor = [UIColor redColor];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(109,91)];
    [path addCurveToPoint: CGPointMake(102,38) controlPoint1: CGPointMake(106,59) controlPoint2: CGPointMake(107,46)];
    [path addCurveToPoint: CGPointMake(71,18) controlPoint1: CGPointMake(97,30) controlPoint2: CGPointMake(74,22)];
    [path addCurveToPoint: CGPointMake(68,14) controlPoint1: CGPointMake(69,16) controlPoint2: CGPointMake(68,14)];
    [path addLineToPoint: CGPointMake(68,14)];
    [path addCurveToPoint: CGPointMake(69,13) controlPoint1: CGPointMake(69,14) controlPoint2: CGPointMake(69,13)];
    [path addCurveToPoint: CGPointMake(68,11) controlPoint1: CGPointMake(69,12) controlPoint2: CGPointMake(68,12)];
    [path addLineToPoint: CGPointMake(68,10)];
    [path addCurveToPoint: CGPointMake(68,2) controlPoint1: CGPointMake(68,9) controlPoint2: CGPointMake(68,2)];
    [path addCurveToPoint: CGPointMake(55,0) controlPoint1: CGPointMake(68,2) controlPoint2: CGPointMake(67,0)];
    [path addCurveToPoint: CGPointMake(42,2) controlPoint1: CGPointMake(55,0) controlPoint2: CGPointMake(42,0)];
    [path addCurveToPoint: CGPointMake(42,10) controlPoint1: CGPointMake(42,5) controlPoint2: CGPointMake(42,10)];
    [path addLineToPoint: CGPointMake(42,11)];
    [path addCurveToPoint: CGPointMake(41,13) controlPoint1: CGPointMake(41,11) controlPoint2: CGPointMake(41,12)];
    [path addLineToPoint: CGPointMake(41,14)];
    [path addLineToPoint: CGPointMake(40,16)];
    [path addLineToPoint: CGPointMake(22,27)];
    [path addLineToPoint: CGPointMake(20,36)];
    [path addLineToPoint: CGPointMake(14,43)];
    [path addCurveToPoint: CGPointMake(2,129) controlPoint1: CGPointMake(14,43) controlPoint2: CGPointMake(2,94)];
    [path addCurveToPoint: CGPointMake(4,154) controlPoint1: CGPointMake(2,145) controlPoint2: CGPointMake(4,154)];
    [path addCurveToPoint: CGPointMake(10,163) controlPoint1: CGPointMake(4,154) controlPoint2: CGPointMake(6,160)];
    [path addCurveToPoint: CGPointMake(25,167) controlPoint1: CGPointMake(13,167) controlPoint2: CGPointMake(19,167)];
    [path addCurveToPoint: CGPointMake(81,166) controlPoint1: CGPointMake(31,167) controlPoint2: CGPointMake(81,166)];
    [path addLineToPoint: CGPointMake(84,164)];
    [path addLineToPoint: CGPointMake(87,167)];
    [path addLineToPoint: CGPointMake(98,167)];
    [path addCurveToPoint: CGPointMake(107,158) controlPoint1: CGPointMake(98,167) controlPoint2: CGPointMake(105,167)];
    [path addCurveToPoint: CGPointMake(109,91) controlPoint1: CGPointMake(109,150) controlPoint2: CGPointMake(113,123)];
    [strokeColor setStroke];
    path.lineWidth = 1;
    [path stroke];

    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = path.CGPath;
    
    
//    mask.path = self.clippingView.clippingPath.CGPath;
//    self.clippingView.layer.mask = mask;
    
    //UIView * whiteView = [[UIView alloc]initWithFrame:self.milkJugView.bounds];
    //whiteView.backgroundColor = [UIColor whiteColor];
     self.whiteView.layer.mask = mask;
    //whiteView.frame.origin = self.milkJugView.center;
    //[self.backgroundView addSubview:whiteView];
   UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, self.milkJugView.bounds.size.height, 1000, -150)];
    
//
   // UIView * whiteView = [[UIView alloc]initWithFrame:self.milkJugView.bounds];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.whiteView addSubview:whiteView];
    
    [self.milkyWeigh.firebaseRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        id rawVal = snapshot.value;
        if (rawVal != [NSNull null])
        {
            NSDictionary* val = rawVal;
            float percentageLeft = [(NSNumber *)[val objectForKey:@"weight"] doubleValue]/100;
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
