//
//  ProductCollectionViewController.h
//  MobiUs
//
//  Created by Myles Caley on 10/7/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
// TODO: use dictionary
@property (strong, nonatomic) NSMutableArray *productImages;
@property (strong, nonatomic) NSMutableArray *productLabels;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@end
