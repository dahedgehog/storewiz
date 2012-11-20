//
//  SWDProductItem.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 11/17/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProduct.h"

@implementation SWDProduct

- (id)initWIthLabel:(NSString *)label price:(NSString *)price
             coordX:(NSUInteger)x coordY:(NSUInteger)y
{
    self = [super init];
    if (self) {
        self.label = label;
        self.price = price;
        self.coordX = x;
        self.coordY = y;
        
        return self;
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    SWDProduct *copy = [[[self class] alloc] init];
    if (copy) {
        copy.label = self.label;
        copy.price = self.price;
        copy.coordX = self.coordX;
        copy.coordY = self.coordY;
        
        return copy;
    }
    return nil;
}

@end
