/*
 * Copyright (c) 2014 FirstBuild
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

//
//  ColorViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "ChillHubViewController.h"
#import "ChillHubDevicesTableViewController.h"
#import "CFSharer.h"
#import "FBTUser.h"
#import "FSTMilkyWeigh.h"
#import "ScaleViewController.h"
#import "FirebaseShared.h"

#import <SWRevealViewController.h>
#import <Firebase/Firebase.h>

@interface ChillHubViewController ()
//@property (nonatomic, strong) CFShareCircleView *shareCircleView;

@end

@implementation ChillHubViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ScaleViewController class]] )
    {
        ScaleViewController* scale = (ScaleViewController*) segue.destinationViewController;
        scale.milkyWeigh = (FSTMilkyWeigh*)((CFSharer*) sender).product;
    }
    else if ([segue.identifier isEqualToString:@"segueDevices"])
    {
        ChillHubDevicesTableViewController * devicesController = (ChillHubDevicesTableViewController *) [segue destinationViewController];
        devicesController.chillhub = (FSTChillHub*)self.product;
    }
   
}

//- (void)shareCircleView:(CFShareCircleView *)shareCircleView didSelectSharer:(CFSharer *)sharer {
//    NSLog(@"Selected sharer: %@", sharer.name);
//    
//    if (sharer.type==CFSharerTypeMilkScale)
//    {
//        [self performSegueWithIdentifier:@"scale" sender:sharer];
//    }
//}
//
//- (void)shareCircleView:(CFShareCircleView *)shareCircleView didCancelSharer:(CFSharer *)sharer {
//    NSLog(@"Share circle view was canceled.");
//    [self.revealViewController revealToggle:self];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.shareCircleView = [[CFShareCircleView alloc] initWithFrame:self.view.bounds];
//    self.shareCircleView.delegate = self;
//    [self.view addSubview:self.shareCircleView];
}

- (void)viewWillAppear:(BOOL)animated
{
    //TODO: figure out whats going on with the observers -- it isn't correct
    [super viewWillAppear:animated];
    //[self.shareCircleView removeAllAccessories];
    
    [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

#pragma mark state preservation / restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Save what you need here
//    [coder encodeObject: _text forKey: @"text"];
//    [coder encodeObject: _color forKey: @"color"];
//
//    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Restore what you need here
//    _color = [coder decodeObjectForKey: @"color"];
//    _text = [coder decodeObjectForKey: @"text"];
//    
//    [super decodeRestorableStateWithCoder:coder];
}

- (IBAction)revealToggle:(id)sender
{
    [self.revealViewController revealToggle:sender];
}

- (void)applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
}


@end
