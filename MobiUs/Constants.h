//
//  Constants.h
//  MobiUs
//
//  Created by Myles Caley on 10/15/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#ifndef MobiUs_Constants_h
#define MobiUs_Constants_h

FOUNDATION_EXPORT NSString *const FirebaseUrl;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:1.0]


#endif
