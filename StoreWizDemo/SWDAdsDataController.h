//
//  SWDAdsDataController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 11/18/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWDAdsDataController : NSObject

@property (copy, nonatomic) NSArray *ads;

- (id)initWithResource:(NSString *)fileName;

@end
