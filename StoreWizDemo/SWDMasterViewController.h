//
//  SWDViewController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ViewDeck/IIViewDeckController.h>

@interface SWDMasterViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

- (void)configureCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
