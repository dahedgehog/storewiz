//
//  SWDShoppingListDataController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 10.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListDataController.h"

@interface SWDShoppingListDataController ()
- (void)initializeShoppings;
@end

@implementation SWDShoppingListDataController

- (id)init {
    self = [super init];
    if (self) {
        [self initializeShoppings];
        return self;
    }
    return nil;
}

- (void)initializeShoppings {
    NSMutableArray *shoppings = [[NSMutableArray alloc] initWithObjects:
                                 @"Oma Lista 1", @"Oma Lista 2", @"Oma Lista 3", nil];
    self.shoppingLists = shoppings;
}

- (void)setShoppingLists:(NSMutableArray *)shoppings {
    if (_shoppingLists != shoppings) {
        _shoppingLists = [shoppings mutableCopy];
    }
}

- (NSUInteger)countOfShoppingLists {
    return [self.shoppingLists count];
}

- (NSString *)objectInShoppingListsAtIndex:(NSUInteger)index {
    return [self.shoppingLists objectAtIndex:index];
}

- (void)addShoppingListWithShoppingList:(NSString *)shoppingList {
    [self.shoppingLists addObject:shoppingList];
}

@end
