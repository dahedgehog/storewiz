//
//  SWDAdsDataController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 11/18/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDAdsDataController.h"
#import "SWDProductItem.h"

@implementation SWDAdsDataController

- (id)initWithResource:(NSString *)fileName
{
    self = [super init];
    if (self) {
        NSError *error;
        
        NSString *resource = [[NSBundle mainBundle] pathForResource:fileName ofType:@"csv"];
        NSString *contents = [NSString stringWithContentsOfFile:resource
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
        
        NSMutableArray *ads = [[NSMutableArray alloc] init];
        
        NSArray *lines = [contents componentsSeparatedByString:@"\n"];
        for (NSString *line in lines) {
            NSArray *comps = [line componentsSeparatedByString:@","];
            SWDProductItem *item = [[SWDProductItem alloc] initWIthLabel:comps[0] price:comps[1]
                                                                  coordX:[comps[2] integerValue]
                                                                  coordY:[comps[3] integerValue]];
            [ads addObject:item];
        }
        self.ads = [NSArray arrayWithArray:ads];
        return self;
    }
    return nil;
}

@end
