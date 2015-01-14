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

@interface FBTAuthenticationViewController ()

@end

@implementation FBTAuthenticationViewController


- (void)viewDidLoad
{
    //TODO: fix this... mostly temporary
    [super viewDidLoad];
    NSArray *accounts;
    
    [SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
    accounts = [SSKeychain accountsForService:@"firebase"];
    
    if (accounts)
    {
        NSString* account = [accounts[0] objectForKey:@"acct"];
        NSString* password = [SSKeychain passwordForService:@"firebase" account:account];
       
        //if we have an account already stored in the keychain but this is the first launch
        //then lets erase all
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"])
        {
            [accounts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [SSKeychain deletePasswordForService:@"firebase" account:obj];
            }];
            
            [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"isFirstLaunch"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            self.usernameTextField.text = @"hi@hi.com";
            self.passwordTextField.text = @"hi";
        }
    }

    //TODO: don't play the movie if we are auto logging in
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
    translucentUnderlayment.layer.cornerRadius = 5;
    translucentUnderlayment.layer.masksToBounds = YES;
    [self.controlView addSubview:translucentUnderlayment];
    [self.controlView sendSubviewToBack:translucentUnderlayment];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)signInButtonPressed:(id)sender;
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.loginActivityIndicator startAnimating];
    [self loginWithUsernameAndLoadMainApp:self.usernameTextField.text havingPassword:self.passwordTextField.text];
}


- (IBAction)registerButtonPressed:(id)sender;
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.loginActivityIndicator startAnimating];
    
    Firebase *authRef = [[FirebaseShared sharedInstance] firebaseRootReference];
    
    [authRef createUser:self.usernameTextField.text  password:self.passwordTextField.text withCompletionBlock:^(NSError *error) {
         if (error != nil) {
             // There was an error creating the account
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed!" message:@"Please check your email and password, and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alert show];
             [self.loginActivityIndicator stopAnimating];
         }
         else
         {
             [self loginWithUsernameAndLoadMainApp:self.usernameTextField.text havingPassword:self.passwordTextField.text];
         }
    }];
}

- (void) loginWithUsernameAndLoadMainApp:(NSString*)username havingPassword:(NSString*)password
{
    
    // TODO: use setValue with completion block for the creation of the new user
    // TODO: better error checking
    Firebase *authRef = [[FirebaseShared sharedInstance] firebaseRootReference];
    FBTUser *user = [FBTUser sharedInstance];
    
    [authRef authUser:username  password:password withCompletionBlock:^(NSError *error,  FAuthData *authData) {
        if (error == nil)
        {
            user.rootContainer = [@"/users/" stringByAppendingString:authData.uid];
            [[FirebaseShared sharedInstance] setUserBaseReference:[authRef childByAppendingPath:user.rootContainer]];
           
            user.token = authData.token;
            user.email = username;
            
            Firebase *userConnectedRef = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"connected"];
            [userConnectedRef setValue:@YES];
            [userConnectedRef onDisconnectRemoveValue];
            
            [SSKeychain setPassword:password forService:@"firebase" account:username];
            [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
            [self performSegueWithIdentifier:@"main" sender:self];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed!" message:@"Please check your email and password, and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        [self.loginActivityIndicator stopAnimating];
    }];

}

- (IBAction)backgroundTap:(id)sender;
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)usernameDoneEditing:(id)sender;
{
    [self.passwordTextField becomeFirstResponder];
}

- (IBAction)passwordDoneEditing:(id)sender;
{
    [self.passwordTextField resignFirstResponder];
}

# pragma mark - Keyboard will show/hide notifications to scroll the view properly
//- (void)viewWillAppear:(BOOL)animated;
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated;
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    [UIView animateWithDuration:0.3f animations:^{
//        [self.view setFrame:[[UIScreen mainScreen] bounds]];
//    }];
//}
//
//-(void)keyboardWillHide:(NSNotification *)notification
//{
//    [UIView animateWithDuration:0.3f animations:^{
//        [self.view setFrame:[[UIScreen mainScreen] bounds]];
//    }];
//}

@end
