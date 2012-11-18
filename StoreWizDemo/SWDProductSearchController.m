//
//  SWDProductSearchController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductSearchController.h"
#import "SWDProductViewController.h"
#import "SWDProductDataController.h"
#import "SWDProductItem.h"

@implementation SWDProductSearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDProductDataController *ctrl = [[SWDProductDataController alloc] initWithResource:@"tuotekatalogi"];
    
    self.allItems = ctrl.products;
    self.searched = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searched count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductSearchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    SWDProductItem *item = [self.searched objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.label;
    cell.detailTextLabel.text = item.price;
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterContectForSearchText:searchText];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
}

- (void)filterContectForSearchText:(NSString *)searchText
{
    NSPredicate *resultsPred = [NSPredicate predicateWithFormat:@"label contains[cd] %@", searchText];
    self.searched = [self.allItems filteredArrayUsingPredicate:resultsPred];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowProductView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString* product = [self.searched objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProduct:product];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self searchBarCancelButtonClicked:self.searchBar];
    }
}

@end