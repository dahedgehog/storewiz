//
//  SWDRootViewController.m
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 12/3/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDRootViewController.h"
#import "SWDSidebarViewController.h"

@implementation SWDRootViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *mv = [sb instantiateViewControllerWithIdentifier:@"MasterView"];
    
    self = [super initWithCenterViewController:[[UINavigationController alloc] initWithRootViewController: mv]
                            leftViewController:[[SWDSidebarViewController alloc] init]];
    return self;
}

@end
