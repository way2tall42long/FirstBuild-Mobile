//
//  ProductMainViewController.m
//  MobiUs
//
//  Created by Myles Caley on 12/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "ProductMainViewController.h"
#import "FirebaseShared.h"
#import <Firebase/Firebase.h>
#import <SWRevealViewController.h>

@interface ProductMainViewController ()

@end

@implementation ProductMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    [[self.buttonAddProduct imageView] setContentMode: UIViewContentModeScaleAspectFit];
    [self.buttonAddProduct setImage:[UIImage imageNamed:@"btn_blue_large_with_field_plus_add_product"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //TODO: not sure if this is the correct pattern. we want to show the "no products"
    //found if there really aren't any products. since there is no timeout concept on the firebase
    //API then am not sure what the correct method is for detecting a network error.
    
    Firebase * ref = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"devices"];
    
    [self.productsCollectionView setHidden:YES];
    [self.noProductsView setHidden:YES];
    [self.loadingIndicator startAnimating];
    
    [ref observeSingleEventOfType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self.loadingIndicator stopAnimating];
        [self.productsCollectionView setHidden:NO];
        [self.noProductsView setHidden:YES];
    } withCancelBlock:^(NSError *error) {
        //TODO: if its really a permission error then we need to handle this differently
        NSLog(@"%@",error.localizedDescription);
        [self.loadingIndicator stopAnimating];
        [self.noProductsView setHidden:YES];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingIndicator stopAnimating];
        [self.productsCollectionView setHidden:YES];
        [self.noProductsView setHidden:NO];
    });

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (IBAction)revealButtonClick:(id)sender {
    [self.revealViewController revealToggle:sender];
}

//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.products.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    ProductCollectionViewCell *productCell =
//    [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    
//    productCell.layer.cornerRadius = 10;
//    productCell.layer.masksToBounds = YES;
//    
//    return productCell;
//}
//
//#pragma mark <UICollectionViewDelegate>
//
//- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    FSTProduct * product = self.products[indexPath.row];
//    NSLog(@"selected %@", product.identifier);
//    
//    if ([product isKindOfClass:[FSTChillHub class]])
//    {
//        [self performSegueWithIdentifier:@"segueChillHub" sender:product];
//    }
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
