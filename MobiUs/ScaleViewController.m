//
//  ScaleViewController.m
//  MobiUs
//
//  Created by Myles Caley on 10/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "ScaleViewController.h"
#import <Firebase/Firebase.h>

@implementation ScaleViewController

NSString *const dummyurl = @"https://mobius-firstbuild.firebaseio.com/objects/-JUAwerASDvas-1g12j";

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
            [[self spinnerView] setProgress:[(NSNumber *)[val objectForKey:@"percent"] doubleValue]/100 animated:YES];
        }
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
        
    }];
}
@end
