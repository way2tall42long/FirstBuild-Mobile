//
//  Sharer.m
//  CFShareCircle
//
//  Created by Camden on 1/15/13.
//  Copyright (c) 2013 Camden. All rights reserved.
//

#import "CFSharer.h"

@implementation CFSharer

- (id)initWithName:(NSString *)name imageName:(NSString *)imageName withDevice:(FSTProduct *)device havingType:(CFSharerType)type
{
    self = [super init];
    if (self) {
        _name = name;
        _image = [UIImage imageNamed:imageName];
        _product = device;
    }
    return self;    
}

//+ (CFSharer *)beer {
//    return [[CFSharer alloc] initWithName:@"Beer Tracker" imageName:@"beer.png"];
//}
//
//+ (CFSharer *)scale {
//    return [[CFSharer alloc] initWithName:@"Milk Minder" imageName:@"scale.png"];
//}
//
//+ (CFSharer *)quickchill {
//    return [[CFSharer alloc] initWithName:@"QuickChill" imageName:@"quickchill.png"];
//}



@end
