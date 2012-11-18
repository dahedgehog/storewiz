//
//  SWDShoppingListTabBarController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListTabBarController.h"

@implementation SWDShoppingListTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.shoppingList.name;
    
    UIImage *image = [UIImage imageNamed:@"locate.png"];
    
    self.locateButton = [[UIBarButtonItem alloc] initWithImage:image
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(locateMe)];
    
    self.locateButton.imageInsets = UIEdgeInsetsMake(5, 6, 5, 6);
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 1) {
        [self.navigationItem setRightBarButtonItem:self.addItemButton animated:NO];

    } else if (item.tag == 2) {
        [self.navigationItem setRightBarButtonItem:self.locateButton animated:NO];
        
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:NO];
    }
}

- (void)addListItem:(id)sender
{
    //Here the addition of new shopping list...
}

- (void)locateMe
{
    //Here the location code for the controller...
}

@end
