//
//  FBTAuthenticationViewController.h
//  iOS Firebase Template
//
//  Created by Michael McDonald on 4/17/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <GooglePlus/GooglePlus.h>
#import <FacebookSDK/FacebookSDK.h>

@class GPPSignInButton;

@interface FBTAuthenticationViewController : UIViewController <GPPSignInDelegate,FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (strong, nonatomic) MPMoviePlayerController *backgroundMovie;
@property (strong, nonatomic) IBOutlet UIControl *controlView;
@property (strong, nonatomic) IBOutlet GPPSignInButton *googleLoginView;
@property (strong, nonatomic) IBOutlet FBLoginView *facebookLoginView;

- (IBAction)signInButtonPressed:(id)sender;
- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)usernameDoneEditing:(id)sender;
- (IBAction)passwordDoneEditing:(id)sender;

@end
