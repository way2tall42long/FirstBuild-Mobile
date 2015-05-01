//
//  FSTMeateor.h
//  FirstBuild
//
//  Created by Troy Kremer on 4/14/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSTChillHubDevice.h"

@interface FSTMeateor : FSTChillHubDevice

extern NSString *const DATAMAPPING_MEATEOR;

@property (strong, nonatomic) NSString* Status;
@property (strong, nonatomic) NSString* MeatType;
@property (strong, nonatomic) NSString* CompletionTime;

@end
