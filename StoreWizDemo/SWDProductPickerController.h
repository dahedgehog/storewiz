//
//  SWDProductPickerController.h
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 18.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductSearchController.h"
#import "SWDProduct.h"

@protocol SWDProductPickerControllerDelegate <NSObject>

- (void)productSelected:(SWDProduct *)product;

@end

@interface SWDProductPickerController : SWDProductSearchController

@property (strong, nonatomic) id <SWDProductPickerControllerDelegate> delegate;

@end
