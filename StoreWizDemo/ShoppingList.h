//
//  ShoppingList.h
//  Pods
//
//  Created by Tuomas Vuori on 11/23/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ShoppingList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSManagedObject *products;

@end
