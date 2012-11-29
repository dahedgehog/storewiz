//
//  SWDShoppingListTabBarController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWDShoppingList.h"
#import "SWDSidebarViewController.h"
#import "JTRevealSidebarV2Delegate.h"

@interface SWDShoppingListTabBarController : UITabBarController <UITabBarDelegate, JTRevealSidebarV2Delegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addItemButton;
@property (strong, nonatomic) SWDShoppingList *shoppingList;

@end
