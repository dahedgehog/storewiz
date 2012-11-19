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

@implementation SWDShoppingListMapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDAdsDataController *ads = [[SWDAdsDataController alloc] initWithResource:@"mainokset"];
    SWDProductItem *ad = [ads.ads objectAtIndex:(arc4random() % [ads.ads count])];
    
    UIImage *img  = [UIImage imageNamed:ad.label];
    self.adView.image = img;

    UIImage *map = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    UIImage *pin = [UIImage imageNamed:@"product_pin.png"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:map];
    imageView.frame = CGRectMake(0, pin.size.height+50,
                                 map.size.width, map.size.height);
    [self.scrollView addSubview:imageView];

    
    [self.scrollView setContentSize:CGSizeMake(map.size.width+pin.size.width,
                                               map.size.height+pin.size.height+50)];
}

@end
