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
    NSMutableArray *_images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@""];
    
    _images = [NSMutableArray arrayWithCapacity:paths.count];
     for(NSString *path in paths) {
        [_images addObject:[UIImage imageWithContentsOfFile:path]];
    }
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"06-magnify-white-shadow.png"]];
//    searchImageView.userInteractionEnabled = YES;
//    [searchImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchButtonTapped:)]];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.showsTouchWhenHighlighted = YES;
    searchButton.frame = CGRectMake(0,0,22,22);
    [searchButton setImage:[UIImage imageNamed:@"06-magnify-white-shadow.png"] forState:UIControlStateNormal];
    searchButton.userInteractionEnabled = YES;
    [searchButton addTarget:self action:@selector(searchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *menuImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"]];
    menuImageView.userInteractionEnabled = YES;
    [menuImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    
    self.navigationItem.leftBarButtonItem.customView = menuImageView;
    self.navigationItem.rightBarButtonItem.customView = searchButton;
    
    UIColor *pattern = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"billie_holiday.png"]];
    self.collectionView.backgroundColor = pattern;
    self.navigationItem.title = @"CM Kupittaa";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewDeckController.panningMode = IIViewDeckFullViewPanning;
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"navbar-shadow.png"]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

- (void)searchButtonTapped:(id)sender
{
    NSLog(@"Performing product search segue");
    [self performSegueWithIdentifier:@"ProductSearchSegue" sender:self.navigationItem.leftBarButtonItem];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[_images objectAtIndex:indexPath.row]];
    imageView.frame = CGRectMake(0,0,96.5,96.5);
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [cell.contentView addSubview:imageView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addButton.frame = CGRectMake(cell.contentView.frame.size.width - 25, cell.contentView.frame.size.height - 25, 25, 25);
    [addButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addButtonTapped:)]];
    
    [cell.contentView addSubview:addButton];
    
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

- (void)addButtonTapped:(id)sender
{
    [SVProgressHUD showSuccessWithStatus:@"Tuote lisätty"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)configureCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
}

- (void)menuButtonTapped:(UIBarButtonItem *)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

@end
