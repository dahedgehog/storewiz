//
//  SWDMapOffersViewController.m
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 12/3/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDMapOffersViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SWDMapOffersViewController ()

@end
    
@implementation SWDMapOffersViewController
{
    NSArray *_paths;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _paths = [[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:@""];
    NSLog(@"%u", _paths.count);
    
    self.collectionView.backgroundColor = nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _paths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MapOfferImageCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:_paths[indexPath.row]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0,0,65.5,65.5);
    
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0,3);
    cell.layer.shadowOpacity = 0.7f;
    cell.layer.shadowRadius = 1.5f;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:imageView.frame].CGPath;
    cell.layer.shouldRasterize = YES;
    
    [cell.contentView addSubview:imageView];
    
    return cell;
}

@end
