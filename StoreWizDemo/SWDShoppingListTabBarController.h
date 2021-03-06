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

@interface SWDShoppingListTabBarController : UITabBarController <UITabBarDelegate>

@property (strong, nonatomic) SWDShoppingList *shoppingList;
- (IBAction)menuButtonTapped:(UIBarButtonItem *)sender;

@end
