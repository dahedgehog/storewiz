//
//  SWDShoppingListDataController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 10.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWDShoppingList.h"

@interface SWDShoppingListDataController : NSObject

@property (copy, nonatomic) NSMutableArray *shoppingLists;

- (NSUInteger)countOfShoppingLists;
- (SWDShoppingList *)objectInShoppingListsAtIndex:(NSUInteger)index;
- (void)addShoppingListWithShoppingList:(SWDShoppingList *)shoppingList;

@end
