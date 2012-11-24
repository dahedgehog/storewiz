//
//  SWDShoppingList.h
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/24/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SWDProduct;

@interface SWDShoppingList : NSManagedObject

@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *products;
@end

@interface SWDShoppingList (CoreDataGeneratedAccessors)

- (void)addProductsObject:(SWDProduct *)value;
- (void)removeProductsObject:(SWDProduct *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
