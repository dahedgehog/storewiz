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
#import <IIViewDeckController.h>

@interface SWDProductSearchController ()

@end

@implementation SWDProductSearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDProductDataController *ctrl = [[SWDProductDataController alloc] initWithResource:@"katalogi-3"];
    
    self.allItems = ctrl.products;
    self.searched = self.allItems;
    
    self.sections = [self sectionsGroupedByKeyPath:@"category"];
    
    self.viewDeckController.panningMode = IIViewDeckNoPanning;
    
    self.navigationController.navigationBar.shadowImage = nil;
}

- (NSArray *)sectionsGroupedByKeyPath:(NSString *)keyPath
{
	NSMutableArray *sections = [NSMutableArray array];
    
	// If we don't contain any items, return an empty collection of sections.
	if([self.searched count] == 0)
		return sections;
    
	// Create the first section and establish the first section's grouping value.
	NSMutableArray *sectionItems = [NSMutableArray array];
	id currentGroup = [[self.searched objectAtIndex:0] valueForKey:keyPath];
    
	// Iterate over our items, placing them in the appropriate section and
	// creating new sections when necessary.
	for(id item in self.searched)
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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sections objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SWDProduct *product = [[self.sections objectAtIndex:section] firstObject];
    return product.category;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductSearchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];

    SWDProduct *item = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.textLabel.font = [UIFont fontWithName:@"Interstate-Regular" size:15.0f];
    cell.textLabel.frame = CGRectOffset(cell.textLabel.frame, 0, 6);
    cell.detailTextLabel.text = [item.price.stringValue stringByAppendingString:@" €"];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Interstate-Regular" size:14.0f];
    
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
    self.sections = [self sectionsGroupedByKeyPath:@"category"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowProductView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        SWDProduct* product = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProducts:[NSArray arrayWithObject:product]];
        [[segue destinationViewController] setScrollsToCenterPointAfterAppear:YES];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self searchBarCancelButtonClicked:self.searchBar];
    }
}

@end
