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
@required

- (void)productPickerDidSelectProduct:(SWDProduct *)product;

@end

@interface SWDProductPickerController : SWDProductSearchController

@property (nonatomic, weak) id <SWDProductPickerControllerDelegate> delegate;
- (IBAction)closeButtonTapped:(UIBarButtonItem *)sender;

@end
