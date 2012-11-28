//
//  SWDViewController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDMasterViewController.h"

@interface SWDMasterViewController ()

@end

@implementation SWDMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *pattern = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fabric_plaid.png"]];
    self.view.backgroundColor = pattern;
     
    UIImage *searchImage = [UIImage imageNamed:@"06-magnify-white-shadow.png"];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:searchImage];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchImageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
