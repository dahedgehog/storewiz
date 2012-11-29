//
//  SWDViewController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDMasterViewController.h"
#import "SWDSidebarViewController.h"

@interface SWDMasterViewController ()

@property (strong, nonatomic) SWDSidebarViewController *leftSidebarViewController;

@end

@implementation SWDMasterViewController

@synthesize leftSidebarViewController;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set background pattern
    UIColor *pattern = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"billie_holiday.png"]];
    self.view.backgroundColor = pattern;
    
    [self.navigationItem setRevealSidebarDelegate:self];
    
    UIImage *searchImage = [UIImage imageNamed:@"06-magnify-white-shadow.png"];
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:searchImage];
    searchImageView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchImageView];
    [searchImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchButtonTapped:)]];
    
    UIImage *menuImage = [UIImage imageNamed:@"nav_menu_icon.png"];
    UIImageView *menuImageView = [[UIImageView alloc] initWithImage:menuImage];
    menuImageView.userInteractionEnabled = YES;
    [menuImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    self.navigationController.navigationItem.leftBarButtonItem.customView = menuImageView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuImageView];
}

- (void)searchButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"ProductSearchSegue" sender:self];
}

- (void)menuButtonTapped:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

- (UIView *)viewForLeftSidebar {
    // Use applicationViewFrame to get the correctly calculated view's frame
    // for use as a reference to our sidebar's view
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    SWDSidebarViewController *controller = self.leftSidebarViewController;
    if ( ! controller) {
        self.leftSidebarViewController = [[SWDSidebarViewController alloc] init];
        controller = self.leftSidebarViewController;
        controller.title = @"LeftSidebarViewController";
        controller.sidebarDelegate = self;
    }
    controller.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
