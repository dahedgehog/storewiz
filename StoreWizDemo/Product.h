//
//  Product.h
//  Pods
//
//  Created by Tuomas Vuori on 11/23/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) Category *category;

@end
