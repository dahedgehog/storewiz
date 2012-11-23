//
//  SWDNavigationViewController.m
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/23/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDNavigationController.h"

@implementation SWDNavigationController

@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
