//
//  SWDShoppingList.h
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 18.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWDShoppingList : NSObject<NSCopying>

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSMutableArray *collectedProducts;

@property (strong, nonatomic) NSDate *creationDate;

- (id)initWithName:(NSString *)name;

@end
