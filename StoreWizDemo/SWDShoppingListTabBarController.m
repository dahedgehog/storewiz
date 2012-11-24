//
//  SWDShoppingListTabBarController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListTabBarController.h"
#import "SWDProductPickerController.h"
#import "SWDShoppingListProductsController.h"
#import "SWDMapViewController.h"

@implementation SWDShoppingListTabBarController

@synthesize shoppingList = _shoppingList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.shoppingList.name;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 1) {
        NSLog(@"Showing product listing view");
        [self.navigationItem setRightBarButtonItem:self.addItemButton animated:NO];
        SWDShoppingListProductsController *productsController = (SWDShoppingListProductsController *)self.viewControllers[0];
        productsController.shoppingList = _shoppingList;
    } else if (item.tag == 2) {
        [self.navigationItem setRightBarButtonItem:nil animated:NO];
        NSLog(@"Showing map");
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        SWDMapViewController *mapViewController = (SWDMapViewController *)self.viewControllers[1];
        NSSet *products = [_shoppingList.products filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"collected == NO"]];
        [mapViewController setProducts:[NSMutableArray arrayWithArray:[products allObjects]]];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShoppingListProductSearch"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SWDProductPickerController *productPickerController = navigationController.viewControllers[0];
        productPickerController.delegate = (SWDShoppingListProductsController *)self.selectedViewController;
        productPickerController.navigationItem.leftBarButtonItem.title = _shoppingList.name;
    }
}

@end
