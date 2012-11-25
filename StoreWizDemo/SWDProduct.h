//
//  SWDProduct.h
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/24/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SWDShoppingList;

@interface SWDProduct : NSManagedObject

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSNumber *collected;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSNumber *x;
@property (nonatomic, retain) NSNumber *y;
@property (nonatomic, retain) SWDShoppingList *shoppingList;

@end
