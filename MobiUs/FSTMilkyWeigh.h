//
//  FSTMilkyWeigh.h
//  MobiUs
//
//  Created by Myles Caley on 12/3/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSTChillHubDevice.h"

@interface FSTMilkyWeigh : FSTChillHubDevice

@property (strong, nonatomic) NSString* weight_gal;
@property (strong, nonatomic) NSString* weight_l;

@end
