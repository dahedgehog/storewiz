//
//  SWDSidebarViewController.m
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/28/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <IIViewDeckController.h>
#import "SWDSidebarViewController.h"
#import "SWDShoppingList.h"
#import "SWDShoppingListTabBarController.h"

@interface SWDSidebarViewController() <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UIFont *interstateFont;

@end

@implementation SWDSidebarViewController
{
    BOOL _initialized;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interstateFont = [UIFont fontWithName:@"Interstate-Regular" size:20.0f];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"low_contrast_linen"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.frame = CGRectMake(0,0,self.view.frame.size.width - 22, self.view.frame.size.height);
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_initialized) {
        _initialized = YES;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section) {
        case 0: case 2:
            return 1;
        case 1:
            return 3;
        case 3: default: {
            id sectionInfo = self.fetchedResultsController.sections[0];
            return [sectionInfo numberOfObjects];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return YES;
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 || indexPath.section == 3) {
        return YES;
    }
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleCell"];
        cell.imageView.image = [UIImage imageNamed:@"sidebar-location-arrow.png"];
        
        cell.textLabel.text = @"Supermarket";
        cell.textLabel.textColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.61f alpha:1.0f];
        cell.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.88f];
        cell.textLabel.shadowOffset = CGSizeMake(0, 1);
        cell.textLabel.font = [self.interstateFont fontWithSize:19.0f];
        
        return cell;
        
    } else if(indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OffersCell"];
        
        switch(indexPath.row) {
            case 0:
                cell.textLabel.text = @"Tarjoukset";
                cell.imageView.image = [UIImage imageNamed:@"tags-icon.png"];
                break;
            case 1:
                cell.textLabel.text = @"Reseptit";
                cell.imageView.image = [UIImage imageNamed:@"recipes-icon.png"];
                break;
            case 2:
                cell.textLabel.text = @"Profiili";
                cell.imageView.image = [UIImage imageNamed:@"profile-icon.png"];
                break;
        }
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
        cell.textLabel.shadowOffset = CGSizeMake(0,2);
        cell.textLabel.font = [self.interstateFont fontWithSize:20.0];
        
        return cell;
        
    } else if(indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LabelCell"];
        
        cell.textLabel.text = @"OSTOSLISTAT";
        cell.textLabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
        cell.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
        cell.textLabel.shadowOffset = CGSizeMake(0, 1);
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        button.frame = CGRectOffset(button.frame, tableView.frame.size.width - 40, 9);
        [button addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addShoppingList:)]];
        [cell addSubview:button];
        
        return cell;
        
    } else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShoppingListCell"];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShoppingListCell"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
            cell.textLabel.shadowOffset = CGSizeMake(0,2);
            cell.textLabel.font = [self.interstateFont fontWithSize:20.0f];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        SWDShoppingList *shoppingList = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        cell.textLabel.text = shoppingList.name;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-border-bottom.png"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-selected-cell.png"]];
}

# pragma mark Shopping lists

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        _fetchedResultsController = [SWDShoppingList fetchAllSortedBy:@"creationDate" ascending:NO withPredicate:nil groupBy:nil delegate:self];
    }
    return _fetchedResultsController;
}

- (IBAction)addShoppingList:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uusi ostoslista" message:nil delegate:self cancelButtonTitle:@"Peruuta" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].text = @"Ostoslista";
    [alertView show];
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

- (void)insertNewObject:(id)sender name:(NSString *)name
{
    SWDShoppingList *shoppingList = [SWDShoppingList createEntity];
    shoppingList.name = name;
    shoppingList.creationDate = [NSDate date];
    
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SWDShoppingList *shoppingList = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        [shoppingList deleteEntity];
        
        [[NSManagedObjectContext defaultContext] saveNestedContexts];
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
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    indexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:3];
    newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:3];
    switch(type) {
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    if(indexPath.section == 1) {
        if(indexPath.row == 0) {
            UINavigationController *rootNavi = [sb instantiateViewControllerWithIdentifier:@"RootNavi"];
            self.viewDeckController.centerController = rootNavi;
        } else if(indexPath.row == 1) {
            UINavigationController *recipesNavi = [sb instantiateViewControllerWithIdentifier:@"RecipesNavi"];
            self.viewDeckController.centerController = recipesNavi;
        } else {
            UINavigationController *profileNavi = [sb instantiateViewControllerWithIdentifier:@"ProfileNavi"];
            self.viewDeckController.centerController = profileNavi;
        }
    } else if(indexPath.section == 3) {
        SWDShoppingList *shoppingList = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        
        UINavigationController *listNavi = [sb instantiateViewControllerWithIdentifier:@"ListNavi"];
        id tabBarController = listNavi.topViewController;
        [tabBarController setShoppingList:shoppingList];
        
        self.viewDeckController.centerController = listNavi;
    }
    [self.viewDeckController toggleLeftView];
}

@end
