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

@synthesize products = _products, collectedProducts = _collectedProducts, centerPoint = _centerPoint, scrollsToCenterPointAfterAppear = _scrollsToCenterPointAfterAppear;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDAdsDataController *ads = [[SWDAdsDataController alloc] initWithResource:@"mainokset"];
    NSDictionary *ad = [ads.ads objectAtIndex:(arc4random() % [ads.ads count])];
    
    UIImage *img  = [UIImage imageNamed:[ad valueForKey:@"name"]];
    self.adView.image = img;
    
    UIImage *map = [UIImage imageNamed:@"new_grocery_store.jpeg"];
    
    UIImage *checkbox = [UIImage imageNamed:@"19-circle-check.png"];
    UIImage *highlightedCheckbox = [UIImage imageNamed:@"117-todo-white-highlight.png"];
    
    UIImageView *checkboxView = [[UIImageView alloc] initWithImage:checkbox highlightedImage:highlightedCheckbox];
    checkboxView.userInteractionEnabled = YES;
    [checkboxView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryViewTapped:)]];
    
    _calloutView = [SMCalloutView new];
    _calloutView.delegate = self;
    
    if(!_scrollsToCenterPointAfterAppear) {
        _calloutView.rightAccessoryView = checkboxView;
    }
    
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
    
    if(_scrollsToCenterPointAfterAppear) {
        CGRect origin = self.scrollView.frame;
        CGRect frame = CGRectMake(_centerPoint.x, _centerPoint.y, origin.size.width / 2, origin.size.height / 2);
        [self.scrollView scrollRectToVisible:frame animated:animated];
    }
}

- (void)renderProducts:(NSArray *)products {
    // Remove existing pins from the map and redraw them
    [[_mapView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(SWDProduct *product in products) {
        [self renderProduct:product color:MKPinAnnotationColorGreen tag:[products indexOfObject:product]];
    }
}

- (void)renderProduct:(SWDProduct *)product color:(MKPinAnnotationColor)color tag:(NSUInteger)tag
{
    MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@""];
    pinAnnotationView.center = CGPointMake(product.x.floatValue, product.y.floatValue);
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
    
    _calloutView.title = product.name;
    _calloutView.subtitle = [product.price.stringValue stringByAppendingString:@" €"];
    _calloutView.calloutOffset = pin.calloutOffset;
    [_calloutView presentCalloutFromRect:pin.frame inView:_mapView constrainedToView:self.scrollView permittedArrowDirections:SMCalloutArrowDirectionAny animated:YES];
}

- (void)accessoryViewTapped:(UIGestureRecognizer *)gestureRecognizer
{
    [SVProgressHUD showSuccessWithStatus:_selectedProduct.name];
    _selectedProduct.collected = [NSNumber numberWithBool:YES];
    [_products removeObject:_selectedProduct];
    [self mapTapped];
    [self renderProducts:_products];
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
}

- (void)mapTapped
{
    _selectedProduct = nil;
    [_calloutView dismissCalloutAnimated:YES];
}

@end
