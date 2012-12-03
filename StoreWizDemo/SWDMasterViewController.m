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

@interface SWDMasterViewController ()

@property (strong, nonatomic) SWDSidebarViewController *leftSidebarViewController;

@end

@implementation SWDMasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set background pattern
    UIColor *pattern = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"billie_holiday.png"]];
    self.view.backgroundColor = pattern;
    
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
