//
//  SWDProductItem.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 11/17/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWDProduct : NSObject <NSCopying>

@property (nonatomic) NSString *label;
@property (nonatomic) NSString *price;

@property (nonatomic) NSUInteger coordX;
@property (nonatomic) NSUInteger coordY;

- (id)initWithLabel:(NSString *)label price:(NSString *)price
             coordX:(NSUInteger)x coordY:(NSUInteger)y;

@end
