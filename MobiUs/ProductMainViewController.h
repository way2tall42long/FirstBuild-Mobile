//
//  ProductMainViewController.h
//  MobiUs
//
//  Created by Myles Caley on 12/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductMainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *noProductsView;
@property (strong, nonatomic) IBOutlet UIView *productsCollectionView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddProduct;

@end
