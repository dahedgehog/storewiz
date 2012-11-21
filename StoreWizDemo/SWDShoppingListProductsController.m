//
//  SWDShoppingListProductsController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListProductsController.h"
#import "SWDShoppingListTabBarController.h"
#import "SWDProduct.h"

@implementation SWDShoppingListProductsController
{
    __weak NSMutableArray *products;
}

@synthesize shoppingList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDShoppingListTabBarController *tabBarController = (SWDShoppingListTabBarController *) self.tabBarController;
    self.shoppingList = tabBarController.shoppingList;
    products = shoppingList.products;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SWDProduct *product = [products objectAtIndex:indexPath.row];
    cell.textLabel.text = product.label;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowProductView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        SWDProduct* product = [products objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProducts:[NSArray arrayWithObject:product]];
    }
}

- (void)productPickerDidSelectProduct:(SWDProduct *)product
{
    [products addObject:product];
    [self.tableView reloadData];
    [SVProgressHUD showSuccessWithStatus:@"Tuote lisätty"];
}

@end
