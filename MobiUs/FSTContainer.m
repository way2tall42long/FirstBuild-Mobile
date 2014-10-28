//
//  FSTContainer.m
//  MobiUs
//
//  Created by Myles Caley on 10/28/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "FSTContainer.h"

@implementation FSTContainer

- (id) initWithDictionary:(NSDictionary *)dict;
{
    if ((self = [super init]))
    {
        _cdescription  = [dict valueForKey:@"description"];
        _name   = [dict valueForKey:@"name"];
        _owner = [dict valueForKey:@"owner"];
    }
    
    return self;
}

- (NSDictionary *)toDictionary;
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.cdescription forKey:@"description"];
    [dict setObject:self.name forKey:@"name"];
    [dict setObject:self.owner forKey:@"owner"];
    
    return dict;
}

@end
