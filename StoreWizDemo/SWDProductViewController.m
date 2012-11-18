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
    UIImage *pin = [UIImage imageNamed:@"product_pin.png"];
    
    [self.scrollView setContentSize:CGSizeMake(image.size.width+pin.size.width,
                                               image.size.height+pin.size.height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, pin.size.height, image.size.width, image.size.height);
    [self.scrollView addSubview:imageView];
    
    UIImageView *pinView = [[UIImageView alloc] initWithImage:pin];
    pinView.frame = CGRectMake(self.product.coordX, self.product.coordY,
                               pin.size.width, pin.size.height);
    [self.scrollView addSubview:pinView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSUInteger coordX = self.product.coordX;
    NSUInteger coordY = self.product.coordY;
    coordX = (coordX < 160 ? 0 : coordX - 160);
    coordY = (coordY < 120 ? 0 : coordY - 120);
    
    CGRect visible = CGRectMake(coordX, coordY,
                                self.scrollView.frame.size.width,
                                self.scrollView.frame.size.height);
    
    //UIImageView *visibleView = [[UIImageView alloc] initWithFrame:visible];
    //visibleView.backgroundColor = [UIColor blueColor];
    //[self.scrollView addSubview:visibleView];
    
    [self.scrollView scrollRectToVisible:visible animated:NO];
}

@end
