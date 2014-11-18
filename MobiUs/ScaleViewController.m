//
//  ScaleViewController.m
//  MobiUs
//
//  Created by Myles Caley on 10/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "ScaleViewController.h"
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

NSString *const dummyurl = @"https://mobius-firstbuild.firebaseio.com/objects/-J_M7uoN2pjqP8I7LD3T";

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Firebase *ref = [[Firebase alloc] initWithUrl:dummyurl];

    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        id rawVal = snapshot.value;
        if (rawVal != [NSNull null])
        {
            NSDictionary* val = rawVal;
            float percentageLeft = [(NSNumber *)[val objectForKey:@"weight"] doubleValue];
            [[self spinnerView] setProgress:percentageLeft/100 animated:YES];
        }
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
    }];
}


@end
