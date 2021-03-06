//
//  SWDShoppingListController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#define MR_SHORTHAND
#import "SWDShoppingListController.h"
#import "SWDShoppingListTabBarController.h"
#import "SWDShoppingList.h"
#import "SWDMasterViewController.h"

@interface SWDShoppingListController() <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation SWDShoppingListController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        _fetchedResultsController = [SWDShoppingList fetchAllSortedBy:@"creationDate" ascending:NO withPredicate:nil groupBy:nil delegate:self];
    }
    return _fetchedResultsController;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingListCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (IBAction)addShoppingList:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uusi ostoslista"
                                                        message:nil delegate:self
                                              cancelButtonTitle:@"Peruuta"
                                              otherButtonTitles:@"OK", nil];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0] setText:@"Ostoslista"];
    [alertView show];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        SWDShoppingList *shoppingList = [self.fetchedResultsController objectAtIndexPath:indexPath];

        [shoppingList deleteEntity];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        NSString *shoppingListName = [alertView textFieldAtIndex:0].text;
        if(![shoppingListName isEqualToString:@""]) {
            [self insertNewObject:self name:shoppingListName];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (SWDShoppingList *)insertNewObject:(id)sender name:(NSString *)name
{
    SWDShoppingList *shoppingList = [SWDShoppingList createEntity];
    
    shoppingList.name = name;
    shoppingList.creationDate = [NSDate date];
    
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
    
    return shoppingList;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Preparing for segue...");
    if ([[segue identifier] isEqualToString:@"ShowListView"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        
        SWDShoppingList *shoppingList = [[self fetchedResultsController] objectAtIndexPath:index];
        [[segue destinationViewController] setShoppingList:shoppingList];
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView selectRowAtIndexPath:newIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self performSegueWithIdentifier:@"ShowListView" sender:self];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    SWDShoppingList *shoppingList = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = shoppingList.name;
    cell.contentMode = UIViewContentModeTopLeft;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = [[shoppingList valueForKeyPath:@"products.@sum.price"] stringValue];
    priceLabel.frame = CGRectMake(30, 30, 150, 20);
    NSLog(@"%@ total: %@", shoppingList.name, priceLabel.text);
    [cell addSubview:priceLabel];
    
    cell.detailTextLabel.text = [formatter stringFromDate:shoppingList.creationDate];
}

@end
