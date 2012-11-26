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

@property (strong, nonatomic) NSNumber *scale;

- (void)renderProducts:(NSArray *)products;
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
    
    //NOTE: the map scale factor is now hard coded to 0.5, make this according to the zoom-level!!!
    self.scale = [NSNumber numberWithFloat:0.4];
    
    SWDAdsDataController *ads = [[SWDAdsDataController alloc] initWithResource:@"mainokset"];
    NSDictionary *ad = [ads.ads objectAtIndex:(arc4random() % [ads.ads count])];
    
    UIImage *img  = [UIImage imageNamed:[ad valueForKey:@"name"]];
    self.adView.image = img;
    
    UIImage *map = [UIImage imageNamed:@"kartta-actual-himmee.png"];
    
    UIImage *checkbox = [UIImage imageNamed:@"19-circle-check.png"];
    UIImage *highlightedCheckbox = [UIImage imageNamed:@"117-todo-white-highlight.png"];
    
    UIImageView *checkboxView = [[UIImageView alloc] initWithImage:checkbox highlightedImage:highlightedCheckbox];
    checkboxView.userInteractionEnabled = YES;
    [checkboxView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryViewTapped:)]];
    
    _calloutView = [SMCalloutView new];
    _calloutView.delegate = self;
    
    if(_scrollsToCenterPointAfterAppear) {
        self.navigationItem.title = [[self.products objectAtIndex:0] valueForKey:@"name"];
    } else {
        _calloutView.rightAccessoryView = checkboxView;
    }
    
    _mapView = [[UIImageView alloc] initWithImage:map];
    _mapView.userInteractionEnabled = YES;
    _mapView.frame = CGRectMake(5, 65, map.size.width*self.scale.floatValue, map.size.height*self.scale.floatValue);
    
    [_mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped)]];
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(_mapView.frame.size.width+10,
                                             _mapView.frame.size.height+70);
    self.scrollView.contentMode = UIViewContentModeCenter;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 1.0;
    
    [self.scrollView addSubview:_mapView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _mapView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self renderProducts:_products];
    
    if(_scrollsToCenterPointAfterAppear) {
        CGSize fsize = self.scrollView.frame.size;
        CGRect frame = CGRectMake(_centerPoint.x/2, _centerPoint.y/2,
                                  fsize.width*self.scale.floatValue, fsize.height*self.scale.floatValue);
        
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
    MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil
                                                                             reuseIdentifier:@""];
    
    pinAnnotationView.center = CGPointMake(product.x.floatValue*self.scale.floatValue,
                                           product.y.floatValue*self.scale.floatValue);
    pinAnnotationView.pinColor = color;
    
    // Hack?
    pinAnnotationView.tag = tag;
    
    [pinAnnotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(pinTapped:)]];
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
    [_calloutView presentCalloutFromRect:pin.frame
                                  inView:_mapView
                       constrainedToView:self.scrollView
                permittedArrowDirections:SMCalloutArrowDirectionAny
                                animated:YES];
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
