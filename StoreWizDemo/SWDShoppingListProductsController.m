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
    NSMutableArray *products;
    NSMutableArray *collectedProducts;
    BOOL _productPickerInitiallyShown;
}

@synthesize shoppingList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _productPickerInitiallyShown = NO;
    
    SWDShoppingListTabBarController *tabBarController = (SWDShoppingListTabBarController *) self.tabBarController;
    self.shoppingList = tabBarController.shoppingList;
    products = [NSMutableArray array];
    collectedProducts = [NSMutableArray array];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableView reloadData];
    
    if(products.count == 0 && !_productPickerInitiallyShown) {
        _productPickerInitiallyShown = YES;
        [self.tabBarController performSegueWithIdentifier:@"ShoppingListProductSearch" sender:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Done and undone sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return [products count];
    } else {
        return [collectedProducts count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShoppingListProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SWDProduct *product;
    if(indexPath.section == 0) {
        product = [products objectAtIndex:indexPath.row];
    } else {
        product = [collectedProducts objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = product.label;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView beginUpdates];
    if(indexPath.section == 0) {
        NSLog(@"Marking product as selected");
        SWDProduct *product = [products objectAtIndex:indexPath.row];
        [products removeObjectAtIndex:indexPath.row];
        [collectedProducts addObject:product];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:[collectedProducts indexOfObject:product] inSection:1]];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        SWDProduct *product = [collectedProducts objectAtIndex:indexPath.row];
        [collectedProducts removeObjectAtIndex:indexPath.row];
        [products insertObject:product atIndex:0];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:[products indexOfObject:product] inSection:0]];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView endUpdates];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
