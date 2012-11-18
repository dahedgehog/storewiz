//
//  SWDShoppingListMapController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListMapController.h"

@implementation SWDShoppingListMapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0,
                                      image.size.width,
                                      image.size.height);
    
    [self.scrollView addSubview:imageView];
    [self.scrollView setContentSize:image.size];
}

@end
