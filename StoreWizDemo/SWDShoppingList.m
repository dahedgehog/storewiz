//
//  SWDShoppingList.m
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 18.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingList.h"

@implementation SWDShoppingList

@synthesize name, products, creationDate;

- (id)initWithName:(NSString *)aName
{
    self = [super init];
    if(self) {
        self.name = aName;
        self.products = [NSMutableArray array];
        self.collectedProducts = [NSMutableArray array];
        self.creationDate = [NSDate date];
        return self;
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
