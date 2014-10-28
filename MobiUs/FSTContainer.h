//
//  FSTContainer.h
//  MobiUs
//
//  Created by Myles Caley on 10/28/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "FirebaseProtocol.h"
#import <Foundation/Foundation.h>

@interface FSTContainer : NSObject <FirebaseProtocol>

@property (strong, nonatomic) NSString *cdescription;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *owner;

- (id) initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)toDictionary;

@end
