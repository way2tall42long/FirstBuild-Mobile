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
#import "FBTUser.h"
#import "FSTContainer.h"

@interface FBTAuthenticationViewController ()

@end

@implementation FBTAuthenticationViewController


- (void)viewDidLoad
{
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
            [self loginWithUsernameAndLoadMainApp:account havingPassword:password];
        }
    }

    self.backgroundMovie = [[MPMoviePlayerController alloc] initWithContentURL:
                            [NSURL fileURLWithPath: [[NSBundle mainBundle]
                                                     pathForResource:@"splashvideo" ofType:@"m4v"]]];
    
    self.backgroundMovie.scalingMode = MPMovieScalingModeAspectFill;
    [self.backgroundMovie.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.backgroundMovie setControlStyle:MPMovieControlStyleNone];
    [self.view addSubview:self.backgroundMovie.view];
    [self.view sendSubviewToBack:self.backgroundMovie.view];
    [self.backgroundMovie play];
    
    //TODO: switch to https://github.com/ivoleko/ILTranslucentView for a non hacked version, also allows you to change translucency alpha
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


- (IBAction)cancelButtonPressed:(id)sender;
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
    
    Firebase *authRef = [[Firebase alloc] initWithUrl:FirebaseUrl];
    
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
    Firebase *baseRef = [[Firebase alloc] initWithUrl:FirebaseUrl];
    [baseRef authUser:username  password:password withCompletionBlock:^(NSError *error,  FAuthData *authData) {
        if (error == nil)
        {
            Firebase *connectedRef = [[baseRef childByAppendingPath:@"connections"] childByAppendingPath:authData.uid];
            Firebase *newUserRef = [[baseRef childByAppendingPath:@"users"] childByAppendingPath:authData.uid];
            Firebase *userRootContainerRef = [[baseRef childByAppendingPath:@"containers"] childByAutoId];
            NSDictionary *userDict = [[NSDictionary alloc] initWithObjectsAndKeys:userRootContainerRef.name,@"rootContainer",username,@"email",@"notvalid",@"displayName", nil];
            NSDictionary *containerDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"tbd",@"description",@"tbd",@"name",authData.uid,@"owner", nil];
            FBTUser *newUser = [[FBTUser alloc] initWithDictionary:userDict];
            FSTContainer *newUserContainer = [[FSTContainer alloc]initWithDictionary:containerDict];
            
            [[NSUserDefaults standardUserDefaults] setValue:authData.token forKey:@"firebaseClientToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [newUserRef setValue:[newUser toDictionary]];
            [userRootContainerRef setValue:[newUserContainer toDictionary]];
            [connectedRef setValue:@YES];
            [connectedRef onDisconnectRemoveValue];
            
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
