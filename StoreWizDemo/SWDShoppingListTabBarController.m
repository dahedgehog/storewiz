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

@interface SWDShoppingListTabBarController ()

@property (nonatomic) SWDSidebarViewController *leftSidebarViewController;

@end

@implementation SWDShoppingListTabBarController

@synthesize shoppingList = _shoppingList, leftSidebarViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.shoppingList.name;

    //Set the left navigation item
    UIImage *menuImage = [UIImage imageNamed:@"nav_menu_icon.png"];
    UIImageView *menuImageView = [[UIImageView alloc] initWithImage:menuImage];
    menuImageView.userInteractionEnabled = YES;
    [menuImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSidebar:)]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuImageView];
}

- (void)toggleSidebar:(id)sender
{
    [self.navigationController.viewDeckController toggleLeftViewAnimated:YES];
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
        
        NSString *shoppingListName = [NSString stringWithString:_shoppingList.name];
        
        if(shoppingListName.length > 10) {
            shoppingListName = [[shoppingListName substringToIndex:10] stringByAppendingString:@"..."];
        }
        
        [productPickerController.navigationItem.leftBarButtonItem setTitle:shoppingListName];
    }
}

@end
