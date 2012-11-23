//
//  SWDShoppingListTabBarController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingList.h"

@interface SWDShoppingListTabBarController : UITabBarController <UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addItemButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *locateButton;
@property (strong, nonatomic) ShoppingList *shoppingList;

- (IBAction)addListItem:(id)sender;

@end
