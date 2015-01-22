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

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (strong, nonatomic) MPMoviePlayerController *backgroundMovie;
@property (strong, nonatomic) IBOutlet UIControl *controlView;
@property (strong, nonatomic) IBOutlet GPPSignInButton *googleLoginView;
@property (strong, nonatomic) IBOutlet FBLoginView *facebookLoginView;

@end
