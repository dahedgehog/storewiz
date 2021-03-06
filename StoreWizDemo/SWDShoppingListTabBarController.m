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
#import <ViewDeck/IIViewDeckController.h>

@implementation SWDShoppingListTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.shoppingList.name;

    UIImageView *menuImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"]];
    [menuImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapped:)]];
    self.navigationItem.leftBarButtonItem.customView = menuImageView;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 1) {
        SWDShoppingListProductsController *productsController = (SWDShoppingListProductsController *)self.viewControllers[0];
        productsController.shoppingList = self.shoppingList;
        
    } else if (item.tag == 2) {
        NSSet *products = [self.shoppingList.products filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"collected == NO"]];
        
        SWDMapViewController *mapViewController = (SWDMapViewController *)self.viewControllers[1];
        mapViewController.products = [NSMutableArray arrayWithArray:[products allObjects]];
    }
}

- (IBAction)menuButtonTapped:(UIBarButtonItem *)sender
{
    [self.navigationController.viewDeckController toggleLeftViewAnimated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShoppingListProductSearch"]) {
        [[segue destinationViewController] setDelegate:self.viewControllers[0]];
    }
}

@end
