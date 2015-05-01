//
//  SelectionViewController.m
//  FirstBuild
//
//  Created by Troy Kremer on 4/16/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "SelectionViewController.h"
#import "FirebaseShared.h"
#import <Firebase/Firebase.h>

@interface SelectionViewController ()
{
    NSArray *_typepickerData;
}
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *TypePicker;

@end

@implementation SelectionViewController
- (IBAction)SaveDay:(id)sender {
    
    //grab the date from the Date Picker
    NSDate *chosen = [self.DatePicker date];
    
    //format the time setting??
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH,mm"];
    NSString *time = [formatter stringFromDate:chosen];
    
    //grab the value from the Type Picker
    NSString *typechosen = [self.TypePicker init];
    
            //update firebase data when the *time and *typechosen values change, should only happen at button press
            //defines the location the firebase is being written to
    Firebase *MeatType= [[Firebase alloc] initWithUrl:@"https://firstbuild-sandbox.firebaseio.com/"];
            //writes the data
    [MeatType setValue: [NSString stringWithFormat:@"%@", typechosen]];
   
            //defines the location the firebase is being written to
    Firebase *CompletionTime= [[Firebase alloc] initWithUrl:@"https://firstbuild-sandbox.firebaseio.com/"];
            //writes the data
    [CompletionTime setValue: [NSString stringWithFormat:@"%@", time]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Define values for the picker table
    
    _typepickerData = @[@"Beef", @"Unicorn"];
    
    // Connect data
    self.TypePicker.dataSource = self;
    self.TypePicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Define number of Columns
-(long)numberOfComponentsInPickerView:(UIPickerView *) pickerView
{
    return 1;
}

// Define the number of Rows
- (long)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _typepickerData.count;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
