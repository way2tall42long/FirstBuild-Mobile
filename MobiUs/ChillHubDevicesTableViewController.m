//
//  ChillHubDevicesTableViewController.m
//  MobiUs
//
//  Created by Myles Caley on 12/18/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//
#import "ChillHubDevicesTableViewController.h"
#import "FSTMilkyWeigh.h"
#import "ScaleViewController.h"
#import "ChillHubDeviceTableViewCell.h"
#import "FSTMeateor.h"
#import "MeateorViewController.h"

@interface ChillHubDevicesTableViewController ()

@end

@implementation ChillHubDevicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.products = [[NSMutableArray alloc] init];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FSTChillHubDevice* deviceSelected = (FSTChillHubDevice*)sender;
    if ([segue.destinationViewController isKindOfClass:[ScaleViewController class]] )
    {
        ScaleViewController* scale = (ScaleViewController*) segue.destinationViewController;
        scale.milkyWeigh = (FSTMilkyWeigh*)deviceSelected;
    }
    else if ([segue.destinationViewController isKindOfClass:[MeateorViewController class]] )
    {
        MeateorViewController* Status = (MeateorViewController*) segue.destinationViewController;
        Status.meateor = (FSTMeateor*)deviceSelected;
    }
//***************NOT SURE IF THIS NEEDS TO BE ADDED*****************************
//    else if ([segue.destinationViewController isKindOfClass:[ScaleViewController class]] )
//    {
//        ScaleViewController* scale = (ScaleViewController*) segue.destinationViewController;
//        scale.milkyWeigh = (FSTMilkyWeigh*)deviceSelected;
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    //TODO: consider using another pattern here ...
    //putting the firebase setups stuff inside viewWillAppear
    //because prepareForSegue in the parent controller loads after
    //viewDidLoad
/*    Firebase* ref = [self.chillhub.firebaseRef childByAppendingPath:@"milkyWeighs"];
    [ref removeAllObservers];
    [self.products removeAllObjects];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        {
                FSTMilkyWeigh* milkyWeigh = [FSTMilkyWeigh new];
                milkyWeigh.identifier = snapshot.key;
                milkyWeigh.firebaseRef = snapshot.ref;
                id rawVal = snapshot.value;
                if (rawVal != [NSNull null])
                {
                    NSDictionary* val = rawVal;
                    if ( [(NSString*)[val objectForKey:@"status"] isEqualToString:@"connected"] )
                    {
                        milkyWeigh.online = YES;
                    }
                    else
                    {
                        milkyWeigh.online = NO;
                    }
                }
                [self.products addObject:milkyWeigh];
                [self.tableView reloadData];
        }
        
    }];
    
    [ref observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        for (long i=self.products.count-1; i>-1; i--)
        {
            FSTMilkyWeigh* milkyWeigh = [self.products objectAtIndex:i];
            if ([milkyWeigh.identifier isEqualToString:snapshot.key])
            {
                [self.products removeObject:milkyWeigh];
                [self.tableView reloadData];
                break;
            }
            
        }
    }];
    
    [ref observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        for (long i=self.products.count-1; i>-1; i--)
        {
            FSTChillHubDevice *chillhubDevice = [self.products objectAtIndex:i];
            if ([chillhubDevice.identifier isEqualToString:snapshot.key])
            {
                id rawVal = snapshot.value;
                if (rawVal != [NSNull null])
                {
                    NSDictionary* val = rawVal;
                    if ( [(NSString*)[val objectForKey:@"status"] isEqualToString:@"connected"] )
                    {
                        chillhubDevice.online = YES;
                    }
                    else
                    {
                        chillhubDevice.online = NO;
                    }
                    [self.tableView reloadData];
                }
                break;
            }
        }
    }]; */
/***************************************************************
 *************************MEATeor stuff*************************
 **************************************************************/
    //TODO: consider using another pattern here ...
    //putting the firebase setups stuff inside viewWillAppear
    //because prepareForSegue in the parent controller loads after
    //viewDidLoad
    Firebase* ref = [self.chillhub.firebaseRef childByAppendingPath:@"MEATeor"];
    [ref removeAllObservers];
    [self.products removeAllObjects];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        {
            FSTMeateor* meateor = [FSTMeateor new];
            meateor.identifier = snapshot.key;
            meateor.firebaseRef = snapshot.ref;
            id rawVal = snapshot.value;
            if (rawVal != [NSNull null])
            {
                NSDictionary* val = rawVal;
                if ( [(NSString*)[val objectForKey:@"status"] isEqualToString:@"connected"] )
                {
                    meateor.online = YES;
                }
                else
                {
                    meateor.online = NO;
                }
            }
            [self.products addObject:meateor];
            [self.tableView reloadData];
        }
        
    }];
    
    [ref observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        for (long i=self.products.count-1; i>-1; i--)
        {
            FSTMeateor* meateor = [self.products objectAtIndex:i];
            if ([meateor.identifier isEqualToString:snapshot.key])
            {
                [self.products removeObject:meateor];
                [self.tableView reloadData];
                break;
            }
            
        }
    }];
    
    [ref observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        for (long i=self.products.count-1; i>-1; i--)
        {
            FSTChillHubDevice *chillhubDevice = [self.products objectAtIndex:i];
            if ([chillhubDevice.identifier isEqualToString:snapshot.key])
            {
                id rawVal = snapshot.value;
                if (rawVal != [NSNull null])
                {
                    NSDictionary* val = rawVal;
                    if ( [(NSString*)[val objectForKey:@"status"] isEqualToString:@"connected"] )
                    {
                        chillhubDevice.online = YES;
                    }
                    else
                    {
                        chillhubDevice.online = NO;
                    }
                    [self.tableView reloadData];
                }
                break;
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChillHubDeviceTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"meateor" forIndexPath:indexPath];
    productCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FSTProduct * product = self.products[indexPath.row];
    if (product.online)
    {
        productCell.userInteractionEnabled = YES;
        productCell.disabledView.hidden = YES;
        productCell.detailsButton.hidden = NO;
    }
    else
    {
        productCell.userInteractionEnabled = NO;
        productCell.disabledView.hidden = NO;
        productCell.detailsButton.hidden = YES;
    }
    
    return productCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FSTChillHubDevice * product = self.products[indexPath.row];
    NSLog(@"selected %@", product.identifier);
    
    if ([product isKindOfClass:[FSTMeateor class]])
    {
        [self performSegueWithIdentifier:@"segueMeateor" sender:product];
    }
}


@end
