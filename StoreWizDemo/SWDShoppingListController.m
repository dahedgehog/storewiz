//
//  SWDShoppingListController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListController.h"
#import "SWDShoppingListDataController.h"
#import "SWDShoppingListTabBarController.h"

@implementation SWDShoppingListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataController = [[SWDShoppingListDataController alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfShoppingLists];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShoppingListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *shoppingList = [self.dataController objectInShoppingListsAtIndex:indexPath.row];
    cell.textLabel.text = shoppingList;
    return cell;
}

- (IBAction)addShoppingList:(id)sender {
    [self.dataController addShoppingListWithShoppingList:@"Oma Lista X"];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowListView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString* listName = [self.dataController objectInShoppingListsAtIndex:indexPath.row];
        [[segue destinationViewController] setShoppingList:listName];
        
        //[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

@end
