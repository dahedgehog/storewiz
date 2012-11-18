//
//  SWDShoppingListProductsController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListProductsController.h"
#import "SWDProductViewController.h"

@implementation SWDShoppingListProductsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *products = [[NSArray alloc] initWithObjects:@"Juusto", @"Leipä", @"Kananmuna", nil];
    self.products = products;
                         
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.products objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowProductView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString* product = [self.products objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProduct:product];
    }
}

@end
