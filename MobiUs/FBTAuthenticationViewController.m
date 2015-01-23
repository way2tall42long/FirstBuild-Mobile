//
//  FBTAuthenticationViewController.m
//  iOS Firebase Template
//
//  Created by Michael McDonald on 4/17/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "FBTAuthenticationViewController.h"
#import <Firebase/Firebase.h>
#import <SSKeychain.h>
#import "FirebaseShared.h"
#import "FBTUser.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FBTAuthenticationViewController ()

@end

@implementation FBTAuthenticationViewController

#pragma mark - GPPSignInDelegate

- (void)initGoogleAuth
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.clientID = @"523108828656-nuardro4852mn2g66a8mg9ukj2ld4tf6.apps.googleusercontent.com";;
    signIn.scopes = @[ @"profile" ];
    signIn.delegate = self;
    [signIn trySilentAuthentication];
}

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    Firebase *authRef = [[FirebaseShared sharedInstance] firebaseRootReference];
    [Firebase goOnline];
    if (!error)
    {
        [authRef authWithOAuthProvider:@"google" token:auth.accessToken
               withCompletionBlock:^(NSError *error, FAuthData *authData) {
                   if (error) {
                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Google+ Login Failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                       [alert show];
                   } else {
                       [self loadMainAppWithUidString:authData.uid];
                   }
               }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Google+ Authentication Failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didDisconnectWithError:(NSError *)error
{
    
}

#pragma mark FBLoginViewDelegate

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    Firebase *authRef = [[FirebaseShared sharedInstance] firebaseRootReference];
    [Firebase goOnline];
    NSString *fbAccessToken = [FBSession activeSession].accessTokenData.accessToken;
    [authRef authWithOAuthProvider:@"facebook" token:fbAccessToken
               withCompletionBlock:^(NSError *error, FAuthData *authData) {
                   if (error) {
                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Facebook Login Failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                       [alert show];
                   } else {
                       [self loadMainAppWithUidString:authData.uid];
                   }
               }];
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    // Handle possible errors that can occur during login
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}


#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.facebookLoginView.delegate = self;
    [self initGoogleAuth];
   
    self.backgroundMovie = [[MPMoviePlayerController alloc] initWithContentURL:
                            [NSURL fileURLWithPath: [[NSBundle mainBundle]
                                                     pathForResource:@"splashvideo" ofType:@"mp4"]]];
    
    self.backgroundMovie.scalingMode = MPMovieScalingModeAspectFill;
    [self.backgroundMovie.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.backgroundMovie setControlStyle:MPMovieControlStyleNone];
    [self.view addSubview:self.backgroundMovie.view];
    [self.view sendSubviewToBack:self.backgroundMovie.view];
    [self.backgroundMovie play];
    
    //TODO: is there a more proper way to do this?
    UIToolbar *translucentUnderlayment = [[UIToolbar alloc] init];
    [translucentUnderlayment setFrame:self.controlView.bounds];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [translucentUnderlayment setAlpha:0.9];
    }
    translucentUnderlayment.layer.masksToBounds = YES;
    [self.controlView addSubview:translucentUnderlayment];
    [self.controlView sendSubviewToBack:translucentUnderlayment];

}

- (void) loadMainAppWithUidString: (NSString*) uid
{
    FBTUser *user = [FBTUser sharedInstance];
    Firebase *authRef = [[FirebaseShared sharedInstance] firebaseRootReference];
    
    user.rootContainer = [@"/users/" stringByAppendingString:uid];
    [[FirebaseShared sharedInstance] setUserBaseReference:[authRef childByAppendingPath:user.rootContainer]];
    
    Firebase *userConnectedRef = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"connected1"];
    [userConnectedRef setValue:@YES];
    [userConnectedRef onDisconnectRemoveValue];
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"main" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark FSTApplicationMenuDelegate

- (void)menuLogoutSelected
{
    Firebase* ref =[[FirebaseShared sharedInstance] firebaseRootReference];
    Firebase *userConnectedRef = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"notconnected"];
    [userConnectedRef setValue:@YES];
    [userConnectedRef onDisconnectRemoveValue];
    [[GPPSignIn sharedInstance] signOut];
    [[FBSession activeSession] closeAndClearTokenInformation];
    [ref unauth];
    [Firebase goOffline];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark FirebaseSimpleLogin

//TODO: Firebase Simple Login authentication is currently disabled. e-mail is not validated and requires
//a secondary server to send verification e-mails. This code needs fixed as well.

//- (void)initFirebaseAuthentication
//{
//    NSArray *accounts;
//
//    [SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
//    accounts = [SSKeychain accountsForService:@"firebase"];
//
//    if (accounts)
//    {
//        NSString* account = [accounts[0] objectForKey:@"acct"];
//        NSString* password = [SSKeychain passwordForService:@"firebase" account:account];
//
//        //if we have an account already stored in the keychain but this is the first launch
//        //then lets erase all
//        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"])
//        {
//            [accounts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                [SSKeychain deletePasswordForService:@"firebase" account:obj];
//            }];
//
//            [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"isFirstLaunch"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//        else
//        {
//            self.usernameTextField.text = @"hi@hi.com";
//            self.passwordTextField.text = @"hi";
//        }
//    }
//}

//
//- (IBAction)registerButtonPressed:(id)sender;
//{
//    [self.usernameTextField resignFirstResponder];
//    [self.passwordTextField resignFirstResponder];
//    [self.loginActivityIndicator startAnimating];
//
//    Firebase *authRef = [[FirebaseShared sharedInstance] firebaseRootReference];
//
//    [authRef createUser:self.usernameTextField.text  password:self.passwordTextField.text withCompletionBlock:^(NSError *error) {
//        if (error != nil) {
//            // There was an error creating the account
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed!" message:@"Please check your email and password, and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//            [self.loginActivityIndicator stopAnimating];
//        }
//        else
//        {
//            [self loginWithUsernameAndLoadMainApp:self.usernameTextField.text havingPassword:self.passwordTextField.text];
//        }
//    }];
//}

//- (void) loginWithUsernameAndLoadMainApp:(NSString*)username havingPassword:(NSString*)password
//{
//    
//    // TODO: use setValue with completion block for the creation of the new user
//    // TODO: better error checking
//    Firebase *authRef = [[FirebaseShared sharedInstance] firebaseRootReference];
//    FBTUser *user = [FBTUser sharedInstance];
//    
//    [authRef authUser:username  password:password withCompletionBlock:^(NSError *error,  FAuthData *authData) {
//        if (error == nil)
//        {
//            user.rootContainer = [@"/users/" stringByAppendingString:authData.uid];
//            [[FirebaseShared sharedInstance] setUserBaseReference:[authRef childByAppendingPath:user.rootContainer]];
//            
//            user.token = authData.token;
//            user.email = username;
//            
//            Firebase *userConnectedRef = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"connected"];
//            [userConnectedRef setValue:@YES];
//            [userConnectedRef onDisconnectRemoveValue];
//            
//            [SSKeychain setPassword:password forService:@"firebase" account:username];
//            [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
//            [self performSegueWithIdentifier:@"main" sender:self];
//            
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed!" message:@"Please check your email and password, and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//        }
//        [self.loginActivityIndicator stopAnimating];
//    }];
//    
//}


@end
