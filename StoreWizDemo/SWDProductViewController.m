//
//  SWDProductViewController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductViewController.h"
#import "SWDAdsDataController.h"
#import "SWDProductItem.h"

@implementation SWDProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.product.label;

    SWDAdsDataController *ads = [[SWDAdsDataController alloc] initWithResource:@"mainokset"];
    SWDProductItem *ad = [ads.ads objectAtIndex:(arc4random() % [ads.ads count])];
    
    UIImage *map = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    UIImage *pin = [UIImage imageNamed:@"product_pin.png"];
    UIImage *img  = [UIImage imageNamed:ad.label];
    
    [self.scrollView setContentSize:CGSizeMake(map.size.width+pin.size.width,
                                               map.size.height+pin.size.height+50)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:map];
    imageView.frame = CGRectMake(0, pin.size.height+50,
                                 map.size.width, map.size.height);
    [self.scrollView addSubview:imageView];
    
    UIImageView *pinView = [[UIImageView alloc] initWithImage:pin];
    pinView.frame = CGRectMake(self.product.coordX, self.product.coordY+50,
                               pin.size.width, pin.size.height);
    [self.scrollView addSubview:pinView];
    
    self.adView.image = img;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSUInteger coordX = self.product.coordX+20;
    NSUInteger coordY = self.product.coordY;
    coordX = (coordX < 160 ? 0 : coordX - 160);
    coordY = (coordY < 130 ? 0 : coordY - 130);
    
    CGRect visible = CGRectMake(coordX, coordY,
                                self.scrollView.frame.size.width,
                                self.scrollView.frame.size.height);
    
    [self.scrollView scrollRectToVisible:visible animated:NO];
}

@end
