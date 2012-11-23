//
//  SWDProductSearchController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductSearchController.h"
#import "SWDProductDataController.h"
#import "SWDProduct.h"
#import "SWDMapViewController.h"

@implementation SWDProductSearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDProductDataController *ctrl = [[SWDProductDataController alloc] initWithResource:@"katalogi"];
    
    self.allItems = ctrl.products;
    self.searched = self.allItems;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.searchBar becomeFirstResponder];
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
    
    SWDProduct *item = [self.searched objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.label;
    cell.detailTextLabel.text = item.price;
    
    return cell;
}

#pragma mark - Search bar delegate

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
    if (searchText != @"") {
        NSPredicate *resultsPred = [NSPredicate predicateWithFormat:@"label beginswith[cd] %@", searchText];
        self.searched = [self.allItems filteredArrayUsingPredicate:resultsPred];
    } else {
        self.searched = self.allItems;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowProductView"]) {
        NSLog(@"Showing product view");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        SWDProduct* product = [self.searched objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProducts:[NSArray arrayWithObject:product]];
    
        [[segue destinationViewController] setScrollsToCenterPointAfterAppear:YES];
        [[segue destinationViewController] setCenterPoint:CGPointMake(product.coordX, product.coordY)];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self searchBarCancelButtonClicked:self.searchBar];
    }
}

@end
