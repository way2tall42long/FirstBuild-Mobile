//
//  MeateorViewController.h
//  FirstBuild
//
//  Created by Troy Kremer on 4/14/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTMeateor.h"

@interface MeateorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Status;
@property (strong, nonatomic) FSTMeateor *meateor;
@end
