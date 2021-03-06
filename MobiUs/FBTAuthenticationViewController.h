//
//  FBTAuthenticationViewController.h
//  MobiUs
//
//  Created by Myles Caley on 10/15/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <GooglePlus/GooglePlus.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MenuViewController.h"

@class GPPSignInButton;


@interface FBTAuthenticationViewController : UIViewController <GPPSignInDelegate,FBLoginViewDelegate,FSTApplicationMenuDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (strong, nonatomic) MPMoviePlayerController *backgroundMovie;
@property (strong, nonatomic) IBOutlet UIControl *controlView;
@property (strong, nonatomic) IBOutlet GPPSignInButton *googleLoginView;
@property (strong, nonatomic) IBOutlet FBLoginView *facebookLoginView;

@end
