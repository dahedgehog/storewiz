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
    BOOL _productPickerInitiallyShown;
    NSArray *_products;
}

@synthesize shoppingList = _shoppingList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _shoppingList = [(SWDShoppingListTabBarController *)self.tabBarController shoppingList];
    _productPickerInitiallyShown = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self reloadData];
    
    if(_products.count == 0 && !_productPickerInitiallyShown) {
        _productPickerInitiallyShown = YES;
        [self.tabBarController performSegueWithIdentifier:@"ShoppingListProductSearch" sender:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Done and undone sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShoppingListProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell indexPath:(NSIndexPath *)indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWDProduct *product = [_products objectAtIndex:indexPath.row];
    if(!product.collected.boolValue) {
        product.collected = [NSNumber numberWithBool:YES];
    } else {
        NSLog(@"Marking product as not collected");
        product.collected = [NSNumber numberWithBool:NO];
    }
    
    [self reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)reloadData
{
    NSLog(@"Reloading data");
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"collected" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES]];
    _products = [_shoppingList.products sortedArrayUsingDescriptors:sortDescriptors];
    [self.tableView reloadData];
}

- (void)productPickerDidSelectProduct:(SWDProduct *)product
{
    product.collected = [NSNumber numberWithBool:NO];
    [_shoppingList addProductsObject:product];
    [[NSManagedObjectContext context] saveNestedContexts];
    [SVProgressHUD showSuccessWithStatus:@"Tuote lisätty"];
    [self reloadData];
}

- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    SWDProduct *product = [_products objectAtIndex:indexPath.row];
    cell.textLabel.text = product.name;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if(product.collected.boolValue) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end