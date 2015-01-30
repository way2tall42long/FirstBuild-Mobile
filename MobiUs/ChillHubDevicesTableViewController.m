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
}

-(void)viewWillAppear:(BOOL)animated
{
    //TODO: consider using another pattern here ...
    //putting the firebase setups stuff inside viewWillAppear
    //because prepareForSegue in the parent controller loads after
    //viewDidLoad
    Firebase* ref = [self.chillhub.firebaseRef childByAppendingPath:@"milkyWeighs"];
    [ref removeAllObservers];
    [self.products removeAllObjects];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        {
                FSTMilkyWeigh* milkyWeigh = [FSTMilkyWeigh new];
                milkyWeigh.identifier = snapshot.key;
                milkyWeigh.firebaseRef = snapshot.ref;
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
    
    //TODO: support multiple product types
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"milkyWeighCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FSTChillHubDevice * product = self.products[indexPath.row];
    NSLog(@"selected %@", product.identifier);
    
    if ([product isKindOfClass:[FSTMilkyWeigh class]])
    {
        [self performSegueWithIdentifier:@"segueMilkyWeigh" sender:product];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
