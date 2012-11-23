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
    SWDProduct *_selectedProduct;
}

@synthesize products = _products, collectedProducts = _collectedProducts;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDAdsDataController *ads = [[SWDAdsDataController alloc] initWithResource:@"mainokset"];
    SWDProduct *ad = [ads.ads objectAtIndex:(arc4random() % [ads.ads count])];
    
    UIImage *img  = [UIImage imageNamed:ad.label];
    self.adView.image = img;
    
    UIImage *map = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    
    UIImage *checkbox = [UIImage imageNamed:@"117-todo-white.png"];
    UIImage *highlightedCheckbox = [UIImage imageNamed:@"117-todo-white-highlight.png"];
    UIImageView *checkboxView = [[UIImageView alloc] initWithImage:checkbox highlightedImage:highlightedCheckbox];
    checkboxView.userInteractionEnabled = YES;
    [checkboxView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryViewTapped:)]];
    
    _calloutView = [SMCalloutView new];
    _calloutView.delegate = self;
    _calloutView.rightAccessoryView = checkboxView;
    
    _mapView = [[UIImageView alloc] initWithImage:map];
    _mapView.userInteractionEnabled = YES;
    
    [_mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped)]];
    
    self.scrollView.contentSize = _mapView.frame.size;
    
    [self.scrollView addSubview:_mapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self renderProducts:_products];
}

- (void)renderProducts:(NSArray *)products {
    // Remove existing pins from the map and redraw them
    [[_mapView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(SWDProduct *product in products) {
        [self renderProduct:product color:MKPinAnnotationColorGreen tag:[products indexOfObject:product]];
    }
    //    for(SWDProduct *collectedProduct in _collectedProducts) {
    //        [self renderProduct:collectedProduct color:MKPinAnnotationColorPurple tag:[_collectedProducts indexOfObject:collectedProduct]];
    //    }
}

- (void)renderProduct:(SWDProduct *)product color:(MKPinAnnotationColor)color tag:(NSUInteger)tag
{
    MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@""];
    pinAnnotationView.center = CGPointMake(product.coordX, product.coordY);
    pinAnnotationView.pinColor = color;
    // Hack?
    pinAnnotationView.tag = tag;
    
    [pinAnnotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinTapped:)]];
    
    [_mapView addSubview:pinAnnotationView];
}

- (void)pinTapped:(UITapGestureRecognizer *)sender
{
    MKPinAnnotationView *pin = (MKPinAnnotationView *)sender.view;
    SWDProduct *product = [_products objectAtIndex:pin.tag];
    
    _selectedProduct = product;
    
    _calloutView.title = product.label;
    _calloutView.subtitle = [product.price stringByAppendingString:@" €"];
    _calloutView.calloutOffset = pin.calloutOffset;
    [_calloutView presentCalloutFromRect:pin.frame inView:_mapView constrainedToView:self.scrollView permittedArrowDirections:SMCalloutArrowDirectionAny animated:YES];
}

- (void)accessoryViewTapped:(UIGestureRecognizer *)gestureRecognizer
{
    [SVProgressHUD showSuccessWithStatus:_selectedProduct.label];
    [_products removeObject:_selectedProduct];
    [_collectedProducts addObject:_selectedProduct];
    [self mapTapped];
    [self renderProducts:_products];
}

- (void)mapTapped
{
    _selectedProduct = nil;
    [_calloutView dismissCalloutAnimated:YES];
}

@end
