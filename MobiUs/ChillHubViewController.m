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
#import "CFSharer.h"
#import "FBTUser.h"

#import <SWRevealViewController.h>
#import <Firebase/Firebase.h>

@interface ChillHubViewController ()
@property (nonatomic, strong) CFShareCircleView *shareCircleView;

@end

@implementation ChillHubViewController


- (IBAction)throwmeaway:(id)sender {
    
    [self.shareCircleView addAccessoryWithId:@"butts" withType:CFSharerTypeMilkScale];
}
- (IBAction)throwmeawaytoo:(id)sender {
    [self.shareCircleView removeAccessoryWithId:@"butts"];
}

- (void)shareCircleView:(CFShareCircleView *)shareCircleView didSelectSharer:(CFSharer *)sharer {
    NSLog(@"Selected sharer: %@", sharer.name);
    
    if (sharer.type==CFSharerTypeMilkScale)
    {
        [self performSegueWithIdentifier:@"scale" sender:self];
    }
}

- (void)shareCircleView:(CFShareCircleView *)shareCircleView didCancelSharer:(CFSharer *)sharer {
    NSLog(@"Share circle view was canceled.");
    [self.revealViewController revealToggle:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.shareCircleView = [[CFShareCircleView alloc] initWithFrame:self.view.bounds];
    self.shareCircleView.delegate = self;
    [self.view addSubview:self.shareCircleView];
    
//    FBTUser *user = [FBTUser sharedInstance];
//    
//    Firebase *baseRef = [[Firebase alloc] initWithUrl:FirebaseUrl];
//    Firebase *attachmentsRef = [[baseRef childByAppendingPath:user.rootContainer] childByAppendingPath:@"devices"];
//    
//    NSLog(@"ID %@", self.product.identifier);
    //[self.shareCircleView showAnimated:YES];
//    firebase = [[Firebase alloc] initWithUrl:@"https://mobius-firstbuild.firebaseio.com/homes/home-1/devices/device-1/accessories/accessory-1"];
//    NSMutableDictionary * dictionary = [[NSMutableDictionary dictionary] init];
//    collection = [[FirebaseCollection alloc] initWithNode:firebase dictionary:dictionary type:[FBChillHubAccessoryQuickChill class]];
//
//  
//
//    [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        NSLog(@"stuff");
////        id obj = [self.objects objectForKey:snapshot.name];
////        if (!obj) {
////            NSAssert(false, @"Object not found locally! %@", snapshot.name);
////        }
////        [obj setValuesForKeysWithDictionary:snapshot.value];
////        self.updateCb(obj);
//    }];
//
//    
//    
//    [collection didAddChild:^(FBChillHubAccessoryQuickChill * accessory) {
//        // created remotely or locally, it is called here
//        NSLog(@"add of isOn %@", accessory);
//        if ([accessory.isOn isEqual:@"on"])
//        {
//            self.dummyToggle.on = true;
//        }
//        else
//        {
//            self.dummyToggle.on = false;
//
//        }
//    }];
//    [collection didRemoveChild:^(FBChillHubAccessoryQuickChill * accessory) {
//        NSLog(@"remove of isOn %@", accessory);
//
//    
//    }];
//    [collection didUpdateChild:^(FBChillHubAccessoryQuickChill * accessory) {
//        NSLog(@"change of isOn %@", accessory);
//        if ([accessory.isOn isEqual: @"on"])
//        {
//            self.dummyToggle.on = true;
//        }
//        else
//        {
//            self.dummyToggle.on = false;
//            
//        }
//    
//    }];
    
    
}
//- (IBAction)dummyToggleValueChanged:(id)sender {
//    NSLog(@"switch clicked");
//    FBChillHubAccessoryQuickChill * accessory = [FBChillHubAccessoryQuickChill new];
//    UISwitch * myswitch = (UISwitch *) sender;
//    
//    if (myswitch.on == true)
//    {
//        accessory.isOn = @"true";
//    }
//    else
//    {
//        accessory.isOn = @"false";
//        
//    }
//   [collection addObject:accessory];
//
//}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.shareCircleView refreshView];
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
