//
//  Category.h
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/23/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *products;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addProductsObject:(Product *)value;
- (void)removeProductsObject:(Product *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
