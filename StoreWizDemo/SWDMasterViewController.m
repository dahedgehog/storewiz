//
//  SWDViewController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDMasterViewController.h"
#import "SWDSidebarViewController.h"
#import <IIViewDeckController.h>
#import <QuartzCore/QuartzCore.h>

@interface SWDMasterViewController ()

@property (strong, nonatomic) SWDSidebarViewController *leftSidebarViewController;

@end

@implementation SWDMasterViewController
{
    NSArray *_paths;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set background pattern
    UIColor *pattern = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"billie_holiday.png"]];
    self.collectionView.backgroundColor = pattern;
    
    //Set the left navigation item
    UIImage *menuImage = [UIImage imageNamed:@"nav_menu_icon.png"];
    UIImageView *menuImageView = [[UIImageView alloc] initWithImage:menuImage];
    menuImageView.userInteractionEnabled = YES;
    [menuImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuImageView];
    
    // Set the right navigation item
    UIImage *searchImage = [UIImage imageNamed:@"06-magnify-white-shadow.png"];
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:searchImage];
    searchImageView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchImageView];
    [searchImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchButtonTapped:)]];
    
    _paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@""];
    NSLog(@"%u", _paths.count);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _paths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[_paths objectAtIndex:indexPath.row]]];
    imageView.frame = CGRectMake(0,0,96.5,96.5);
    
    [cell.contentView addSubview:imageView];
    
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Configuring cell");
    CALayer *layer = cell.layer;
    layer.shadowOffset = CGSizeMake(0,3);
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowRadius = 1.5;
    layer.shadowOpacity = 0.7;
    layer.shouldRasterize = YES;
    CGRect f = [cell.contentView.subviews[0] frame];
    layer.shadowPath = [UIBezierPath bezierPathWithRect:f].CGPath;
    [layer setMasksToBounds:NO];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"navbar-shadow.png"]];
}

- (void)searchButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"ProductSearchSegue" sender:self];
}

- (void)menuButtonTapped:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

@end
