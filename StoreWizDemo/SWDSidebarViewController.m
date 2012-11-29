//
//  SWDSidebarViewController.m
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/28/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDSidebarViewController.h"
#import "SWDShoppingList.h"
#import "SWDShoppingListTabBarController.h"
#import <IIViewDeckController.h>

@interface SWDSidebarViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation SWDSidebarViewController
{
    NSFetchedResultsController *_fetchedResultsController;
    UIFont *_interstateFont;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _interstateFont = [UIFont fontWithName:@"Interstate-Regular" size:20.0f];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"low_contrast_linen"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3) {
        return YES;
    }
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3 || indexPath.section == 1) {
        return YES;
    }
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
        default: {
            id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[0];
            return [sectionInfo numberOfObjects];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        UITableViewCell *view = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 48)];
        
        [view setBackgroundColor:[UIColor redColor]];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(8, 8, 250, 25);
        label.text = @"Citymarket Kupittaa";
        label.backgroundColor = [UIColor clearColor];
        label.font = [_interstateFont fontWithSize:19.0f];
        label.textColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.61f alpha:1.0f];
        label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.88f];
        label.shadowOffset = CGSizeMake(0, 1);
        label.textAlignment = NSTextAlignmentCenter;
        
        UIImage *underlineImage = [UIImage imageNamed:@"sidebar-location-underline.png"];
        UIImageView *underlineImageView = [[UIImageView alloc] initWithImage:underlineImage];
        underlineImageView.frame = CGRectOffset(underlineImageView.frame, 2, 36);
        
        [view addSubview:underlineImageView];
        
        UIImage *locationArrowImage = [UIImage imageNamed:@"sidebar-location-arrow.png"];
        UIImageView *locationArrowImageView = [[UIImageView alloc] initWithImage:locationArrowImage];
        locationArrowImageView.frame = CGRectOffset(locationArrowImageView.frame, 14, 4);
        [label addSubview:locationArrowImageView];
        
        [view addSubview:label];
        
        return view;
    } else if(indexPath.section == 1) {
        UITableViewCell *view = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OffersCell"];
        view.textLabel.text = @"Tarjoukset";
        view.textLabel.textColor = [UIColor whiteColor];
        view.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
        view.textLabel.shadowOffset = CGSizeMake(0,2);
        view.textLabel.font = [_interstateFont fontWithSize:19.0];
        view.imageView.image = [UIImage imageNamed:@"tags-icon.png"];
        view.selectionStyle = UITableViewCellSelectionStyleGray;
        return view;
    } else if(indexPath.section == 2) {
        UITableViewCell *view = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        
        [view setBackgroundColor:[UIColor redColor]];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(8, 15, 150, 15);
        label.text = @"OSTOSLISTAT";
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:14.0];
        label.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
        label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
        label.shadowOffset = CGSizeMake(0, 1);
        
        UIImage *plusImage = [UIImage imageNamed:@"sidebar-plus-sign-blue.png"];
        
        UIImageView *plusImageView = [[UIImageView alloc] initWithImage:plusImage];
        plusImageView.frame = CGRectOffset(plusImageView.frame, tableView.frame.size.width - 25, 15);
        plusImageView.userInteractionEnabled = YES;
        [plusImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addShoppingList:)]];
        
        [view addSubview:plusImageView];
        [view addSubview:label];
        
        return view;
    } else {
        static NSString *CellID = @"ShoppingListCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellID];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.font = [_interstateFont fontWithSize:20.0f];
        }
        
        SWDShoppingList *shoppingList = [_fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        cell.textLabel.text = shoppingList.name;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar-selected-cell.png"]];
    } else if(indexPath.section == 3) {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-border-bottom.png"]];
    }
}

# pragma mark Shopping lists


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    _fetchedResultsController = [SWDShoppingList fetchAllSortedBy:@"creationDate" ascending:NO withPredicate:nil groupBy:nil delegate:self];
    
    return _fetchedResultsController;
}


#pragma mark - Table view data source


- (IBAction)addShoppingList:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uusi ostoslista" message:nil delegate:self cancelButtonTitle:@"Peruuta" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
    [[alertView textFieldAtIndex:0] setText:@"Ostoslista"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        SWDShoppingList *shoppingList = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        
        [shoppingList deleteEntity];
        [[NSManagedObjectContext defaultContext] saveNestedContexts];
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

- (SWDShoppingList *)insertNewObject:(id)sender name:(NSString *)name
{
    SWDShoppingList *shoppingList = [SWDShoppingList createEntity];
    
    shoppingList.name = name;
    shoppingList.creationDate = [NSDate date];
    
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
    
    return shoppingList;
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

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    indexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:3];
    newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:3];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView selectRowAtIndexPath:newIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
//            [self performSegueWithIdentifier:@"ShowListView" sender:self];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
    } else if(indexPath.section == 3) {
        SWDShoppingList *shoppingList = [_fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        UIStoryboard *storyboard = self.viewDeckController.centerController.storyboard;
        SWDShoppingListTabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"ShoppingListView"];
        [tabBarController setShoppingList:shoppingList];
        UINavigationController *navigationController = (UINavigationController *)[self.viewDeckController centerController];
        [navigationController pushViewController:tabBarController animated:NO];
        [navigationController setViewControllers:@[tabBarController]];
        [self.viewDeckController toggleLeftViewAnimated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidUnload
{
    NSLog(@"Sidebar unloaded");
}

@end
