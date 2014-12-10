//
//  Sharer.h
//  CFShareCircle
//
//  Created by Camden on 1/15/13.
//  Copyright (c) 2013 Camden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FSTProduct.h"
@interface CFSharer : NSObject

typedef NS_ENUM(NSInteger, CFSharerType)
{
    CFSharerTypeMilkScale
};

@property NSString *name;
@property UIImage *image;
@property NSString* accessoryId;
@property FSTProduct* product;
@property CFSharerType type;


/**
 Initialize a custom sharer with the name that will be presented when hovering over and the name of the image.
 */
- (id)initWithName:(NSString *)name imageName:(NSString *)imageName withDevice:(FSTProduct *)device havingType:(CFSharerType)type;

//+ (CFSharer *)beer;
//+ (CFSharer *)scale;
//+ (CFSharer *)quickchill;


@end
