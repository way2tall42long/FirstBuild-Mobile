//
//  MeateorViewController.m
//  FirstBuild
//
//  Created by Troy Kremer on 4/14/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "MeateorViewController.h"
#import "FirebaseShared.h"
#import <Firebase/Firebase.h>

@interface MeateorViewController ()

@end

@implementation MeateorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self.meateor.firebaseRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        id rawVal = snapshot.value;
//        if (rawVal != [NSNull null])
//        {
//            NSDictionary* val = rawVal;
//            float percentageLeft = [(NSNumber *)[val objectForKey:@"weight"] doubleValue];
//            [self loadMilkJugWithPercent:percentageLeft];
//        }
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
