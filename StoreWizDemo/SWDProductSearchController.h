//
//  SWDProductSearchController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWDProduct.h"

@interface SWDProductSearchController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (copy, nonatomic) NSArray *allItems;
@property (copy, nonatomic) NSArray *searched;

@property (nonatomic) NSArray *sections;

@end
