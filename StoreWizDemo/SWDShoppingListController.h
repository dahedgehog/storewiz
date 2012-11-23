//
//  SWDShoppingListController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SWDShoppingListDataController;

@interface SWDShoppingListController : UITableViewController<UIAlertViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) SWDShoppingListDataController *dataController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)addShoppingList:(id)sender;

@end
