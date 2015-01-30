//
//  ProductCollectionViewController.m
//  MobiUs
//
//  Created by Myles Caley on 10/7/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import "ProductCollectionViewController.h"
#import "ProductCollectionViewCell.h"
#import <SWRevealViewController.h>
#import <RBStoryboardLink.h>
#import "FirebaseShared.h"
#import "FSTChillHub.h"
#import "ChillHubViewController.h"
#import "MobiNavigationController.h"

@interface ProductCollectionViewController ()

@end

@implementation ProductCollectionViewController

static NSString * const reuseIdentifier = @"ProductCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.products = [[NSMutableArray alloc] init];
   
    //TODO: support multiple device types
    Firebase *chillhubsRef = [[[FirebaseShared sharedInstance] userBaseReference] childByAppendingPath:@"devices/chillhubs"];
    [chillhubsRef removeAllObservers];
    
    [chillhubsRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
                FSTChillHub* chillhub = [FSTChillHub new];
                chillhub.firebaseRef = snapshot.ref ;
                chillhub.identifier = snapshot.key;
                [self.products addObject:chillhub];
                [self.productCollection reloadData];
    }];
    
    [chillhubsRef observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        for (long i=self.products.count-1; i>-1; i--)
        {
            FSTChillHub *chillhub = [self.products objectAtIndex:i];
            if ([chillhub.identifier isEqualToString:snapshot.key])
            {
                [self.products removeObject:chillhub];
                [self.productCollection reloadData];
                break;
            }
        }
        if (self.products.count == 0)
        {
            [self.delegate noItemsInCollection];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    //TODO: support other products
    //TODO: highly coupled segue
    RBStoryboardLink *destination = segue.destinationViewController;
    ChillHubViewController *vc = (ChillHubViewController*)destination.scene;
    vc.product = sender;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCollectionViewCell *productCell =
        [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    return productCell;
}

#pragma mark <UICollectionViewDelegate>

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FSTProduct * product = self.products[indexPath.row];
    NSLog(@"selected %@", product.identifier);
    
    if ([product isKindOfClass:[FSTChillHub class]])
    {
        [self performSegueWithIdentifier:@"segueChillHub" sender:product];
    }

}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: I've missed some margin or something on the parent view and am compensating with making
    //it a little larger than the actual
    return CGSizeMake(self.view.bounds.size.width+10, 150);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
