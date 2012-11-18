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

- (IBAction)addShoppingList:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uusi ostoslista" message:nil delegate:self cancelButtonTitle:@"Peruuta" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        NSString *shoppingListName = [alertView textFieldAtIndex:0].text;
        if(![shoppingListName isEqualToString:@""]) {
            [self.dataController addShoppingListWithShoppingList:shoppingListName];
            [self.tableView reloadData];
            NSUInteger index = [self.dataController.shoppingLists indexOfObject:shoppingListName];
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self performSegueWithIdentifier:@"ShowListView" sender:self];
        }
    }
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
