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

@synthesize sections = _sections;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDProductDataController *ctrl = [[SWDProductDataController alloc] initWithResource:@"katalogi"];
    
    self.allItems = ctrl.products;
    self.searched = self.allItems;
    
    _sections = [self sectionsGroupedByKeyPath:@"category"];
}

- (NSArray *)sectionsGroupedByKeyPath:(NSString *)keyPath
{
	NSMutableArray *sections = [NSMutableArray array];
    
	// If we don't contain any items, return an empty collection of sections.
	if([_searched count] == 0)
		return sections;
    
	// Create the first section and establish the first section's grouping value.
	NSMutableArray *sectionItems = [NSMutableArray array];
	id currentGroup = [[_searched objectAtIndex:0] valueForKey:keyPath];
    
	// Iterate over our items, placing them in the appropriate section and
	// creating new sections when necessary.
	for(id item in _searched)
	{
		// Retrieve the grouping value from the current item.
		id itemGroup = [item valueForKey:keyPath];
        
		// Compare the current item's grouping value to the current section's
		// grouping value.
		if(![itemGroup isEqual:currentGroup])
		{
			// The current item doesn't belong in the current section, so
			// store the section we've been building and create a new one,
			// caching the new grouping value.
			[sections addObject:sectionItems];
			sectionItems = [NSMutableArray array];
			currentGroup = itemGroup;
		}
        
		// Add the item to the appropriate section.
		[sectionItems addObject:item];
	}
    
	// If we were adding items to a section that has not yet been added
	// to the aggregate section collection, add it now.
	if([sectionItems count] > 0)
		[sections addObject:sectionItems];
    
	return sections;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.searchBar becomeFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_sections objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SWDProduct *product = [[_sections objectAtIndex:section] firstObject];
    return product.category;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductSearchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    SWDProduct *item = [[_sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [item.price.stringValue stringByAppendingString:@" €"];
    
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
    if ([searchText length] != 0) {
        NSPredicate *resultsPred = [NSPredicate predicateWithFormat:@"(category beginswith[cd] %@) OR (name beginswith[cd] %@)", searchText, searchText];
        self.searched = [self.allItems filteredArrayUsingPredicate:resultsPred];
    } else {
        NSLog(@"Showing all products");
        self.searched = self.allItems;
    }
    _sections = [self sectionsGroupedByKeyPath:@"category"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowProductView"]) {
        NSLog(@"Showing product view");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        SWDProduct* product = [[_sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProducts:[NSArray arrayWithObject:product]];
    
        [[segue destinationViewController] setScrollsToCenterPointAfterAppear:YES];
        [[segue destinationViewController] setCenterPoint:CGPointMake(product.x.floatValue, product.y.floatValue)];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self searchBarCancelButtonClicked:self.searchBar];
    }
}

@end
