//
//  SWDShoppingListController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWDShoppingListDataController;

@interface SWDShoppingListController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic, strong) SWDShoppingListDataController *dataController;

- (IBAction)addShoppingList:(id)sender;

@end
