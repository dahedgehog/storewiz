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
            SWDProduct *item = [[SWDProduct alloc] initWIthLabel:comps[0] price:comps[1]
                                                                  coordX:[comps[2] integerValue]
                                                                  coordY:[comps[3] integerValue]];
            [products addObject:item];
        }
        self.products = [NSArray arrayWithArray:products];
        return self;
    }
    return nil;
}

@end
