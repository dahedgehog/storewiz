//
//  SWDMapViewController.m
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 21.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDMapViewController.h"
#import "SWDProduct.h"
#import "SWDAdsDataController.h"
#import <MapKit/MapKit.h>

@interface SWDMapViewController ()

- (void)renderProduct:(SWDProduct *)product;

@end

@implementation SWDMapViewController
{
    SMCalloutView *_calloutView;
    UIImageView *_mapView;
}

@synthesize products = _products;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDAdsDataController *ads = [[SWDAdsDataController alloc] initWithResource:@"mainokset"];
    SWDProduct *ad = [ads.ads objectAtIndex:(arc4random() % [ads.ads count])];
    
    UIImage *img  = [UIImage imageNamed:ad.label];
    self.adView.image = img;
    
    UIImage *map = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    
    _calloutView = [SMCalloutView new];
    _calloutView.delegate = self;
    
    _mapView = [[UIImageView alloc] initWithImage:map];
    _mapView.userInteractionEnabled = YES;
    
    [_mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped)]];
    
    self.scrollView.contentSize = _mapView.frame.size;
    
    [self.scrollView addSubview:_mapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_products enumerateObjectsUsingBlock:^(SWDProduct *product, NSUInteger idx, BOOL *stop) {
        [self renderProduct:product];
    }];
}

- (void)renderProduct:(SWDProduct *)product
{
    MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@""];
    pinAnnotationView.center = CGPointMake(product.coordX, product.coordY);
    // Hack?
    pinAnnotationView.tag = [_products indexOfObject:product];
    
    [pinAnnotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinTapped:)]];
    
    [_mapView addSubview:pinAnnotationView];
}

- (void)pinTapped:(UITapGestureRecognizer *)sender
{
    MKPinAnnotationView *pin = (MKPinAnnotationView *)sender.view;
    SWDProduct *product = [_products objectAtIndex:pin.tag];
    
    _calloutView.title = product.label;
    _calloutView.subtitle = [product.price stringByAppendingString:@" €"];
    _calloutView.calloutOffset = pin.calloutOffset;
    [_calloutView presentCalloutFromRect:pin.frame inView:_mapView constrainedToView:self.scrollView permittedArrowDirections:SMCalloutArrowDirectionAny animated:YES];
}

- (void)mapTapped
{
    [_calloutView dismissCalloutAnimated:YES];
}

@end
