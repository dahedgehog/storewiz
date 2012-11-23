//
//  Product.h
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 11/23/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) Category *category;

@end
