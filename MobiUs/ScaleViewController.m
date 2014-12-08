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
    Firebase *scaleRef = [[FirebaseShared sharedInstance] currentReference];
    
    
    scaleRef  = [[[[FirebaseShared sharedInstance] currentReference] childByAppendingPath:@"milkscales"] childByAppendingPath:self.identifier];
    
    //https://mobius-firstbuild.firebaseio.com/users/simplelogin%3A42/devices/chillhubs/f90d08d9-734c-49bd-89d4-afbd480452ee/attachments/milkscales/1e5010b6-dd87-42b0-9b21-a6facd925ceb
    [scaleRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        id rawVal = snapshot.value;
        if (rawVal != [NSNull null])
        {
            NSDictionary* val = rawVal;
            float percentageLeft = [(NSNumber *)[val objectForKey:@"weight_gal"] doubleValue];
            [[self spinnerView] setProgress:percentageLeft animated:YES];
        }
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
}

@end
