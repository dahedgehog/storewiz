//
//  SWDProductViewController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductViewController.h"
#import "SWDProductItem.h"

@implementation SWDProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.product.label;

    UIImage *image = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    UIImage *pin = [UIImage imageNamed:@"map-pin-red.png"];
    [self.scrollView setContentSize:image.size];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0,
                                      image.size.width,
                                      image.size.height);
    [self.scrollView addSubview:imageView];
    
    UIImageView *pinView = [[UIImageView alloc] initWithImage:pin];
    pinView.frame = CGRectMake(self.product.coordX-pin.size.width/6,
                               self.product.coordY-pin.size.height/3,
                               pin.size.width/3, pin.size.height/3);
    [self.scrollView addSubview:pinView];
}

@end
