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
  
    [super viewDidLoad];

    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.milkyWeigh.firebaseRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        id rawVal = snapshot.value;
        if (rawVal != [NSNull null])
        {
            NSDictionary* val = rawVal;
            float percentageLeft = [(NSNumber *)[val objectForKey:@"weight"] doubleValue]/100;
            [[self spinnerView] setProgress:percentageLeft animated:YES];
        }
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
}

@end
