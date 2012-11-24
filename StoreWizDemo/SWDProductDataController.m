//
//  SWDProductDataController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 11/18/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductDataController.h"
#import "SWDProduct.h"

@implementation SWDProductDataController

- (id)initWithResource:(NSString *)fileName
{
    self = [super init];
    if (self) {
        NSError *error;
        
        NSString *resource = [[NSBundle mainBundle] pathForResource:fileName ofType:@"csv"];
        NSString *contents = [NSString stringWithContentsOfFile:resource
                                                        encoding:NSUTF8StringEncoding
                                                           error:&error];

        
        NSArray *lines = [contents componentsSeparatedByString:@"\n"];
        NSMutableArray *products = [[NSMutableArray alloc] init];
        for (NSString *line in lines) {
            NSArray *comps = [line componentsSeparatedByString:@","];
            SWDProduct *product = [SWDProduct createEntity];
            product.name = comps[0];
            product.price = [NSNumber numberWithFloat:[comps[1] floatValue]];
            product.x = [NSNumber numberWithInteger:[comps[2] integerValue]];
            product.y = [NSNumber numberWithInteger:[comps[3] integerValue]];
            product.category = comps[4];
            [products addObject:product];
        }
        self.products = [NSArray arrayWithArray:products];
        return self;
    }
    return nil;
}

@end
