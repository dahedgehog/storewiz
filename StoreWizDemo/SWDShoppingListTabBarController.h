//
//  SWDShoppingListTabBarController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWDShoppingListTabBarController : UITabBarController <UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addItemButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *locateButton;
@property (copy, nonatomic) NSString *shoppingList;

- (IBAction)addListItem:(id)sender;

@end
