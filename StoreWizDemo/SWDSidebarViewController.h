//
//  SWDSidebarViewController.h
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/28/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTRevealSidebarV2Delegate.h"

@interface SWDSidebarViewController : UITableViewController

@property (nonatomic) UIViewController <JTRevealSidebarV2Delegate> *sidebarDelegate;

@end
