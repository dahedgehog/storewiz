//
//  SWDRootViewController.m
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 12/3/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDRootViewController.h"
#import "SWDSidebarViewController.h"

@interface SWDRootViewController ()

@end

@implementation SWDRootViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"Initializing...");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self = [super initWithCenterViewController:[[UINavigationController alloc] initWithRootViewController:[sb instantiateViewControllerWithIdentifier:@"MasterView"]]leftViewController:[[SWDSidebarViewController alloc] init]];
    return self;
}

@end
