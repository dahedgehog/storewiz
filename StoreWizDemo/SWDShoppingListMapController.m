//
//  SWDShoppingListMapController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDShoppingListMapController.h"
#import "SWDAdsDataController.h"
#import "SWDProductItem.h"
#import "SWDShoppingList.h"
#import "SWDShoppingListTabBarController.h"

@interface SWDShoppingListMapController ()

- (void)renderProduct:(SWDProductItem *)product;

@end

@implementation SWDShoppingListMapController
{
    UIImage *_pin;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDAdsDataController *ads = [[SWDAdsDataController alloc] initWithResource:@"mainokset"];
    SWDProductItem *ad = [ads.ads objectAtIndex:(arc4random() % [ads.ads count])];
    
    UIImage *img  = [UIImage imageNamed:ad.label];
    self.adView.image = img;

    UIImage *map = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    _pin = [UIImage imageNamed:@"product_pin.png"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:map];
    imageView.frame = CGRectMake(0, _pin.size.height+50,
                                 map.size.width, map.size.height);
    [self.scrollView addSubview:imageView];

    
    [self.scrollView setContentSize:CGSizeMake(map.size.width+_pin.size.width,
                                               map.size.height+_pin.size.height+50)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    SWDShoppingList *shoppingList = ((SWDShoppingListTabBarController *)self.tabBarController).shoppingList;
    
    [shoppingList.products enumerateObjectsUsingBlock:^(SWDProductItem *product, NSUInteger idx, BOOL *stop) {
        [self renderProduct:product];
    }];
}

- (void)renderProduct:(SWDProductItem *)product
{
    UIImageView *pinView = [[UIImageView alloc] initWithImage:_pin];
    pinView.frame = CGRectMake(product.coordX, product.coordY + 50, _pin.size.width, _pin.size.height);
    
    [self.scrollView addSubview:pinView];
}

@end
