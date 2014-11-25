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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *accounts;
 
    [SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
    
    accounts = [SSKeychain accountsForService:@"firebase"];
    
    if (accounts.count == 1)
    {
        //NSDictionary* account = accounts[0];
        NSString* account = [accounts[0] objectForKey:@"acct"];
        NSString* password = [SSKeychain passwordForService:@"firebase" account:account];
        [self loginWithUsernameAndLoadMainApp:account havingPassword:password];
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
          //   [SSKeychain setPassword:instagramToken forService:@"FirstBuildFirebaseAuthService" account:@"com.firstbuild.keychain"];
             [self loginWithUsernameAndLoadMainApp:self.usernameTextField.text havingPassword:self.passwordTextField.text];
         }
    }];
}

- (void) loginWithUsernameAndLoadMainApp:(NSString*)username havingPassword:(NSString*)password
{
    // TODO: save cached credentials after successful login
    // TODO: remove cached credentials after failure
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
            
            [newUserRef setValue:[newUser toDictionary]];
            [userRootContainerRef setValue:[newUserContainer toDictionary]];
            [connectedRef setValue:@YES];
            [connectedRef onDisconnectRemoveValue];
            
            [SSKeychain setPassword:password forService:@"firebase" account:username];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
- (void)viewWillAppear:(BOOL)animated;
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f animations:^{
        [self.view setFrame:CGRectMake(0,-30,320,460)];
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f animations:^{
        [self.view setFrame:CGRectMake(0,0,320,460)];
    }];
}

@end
