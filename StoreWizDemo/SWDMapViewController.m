//
//  SWDMapViewController.m
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 21.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "SWDMapViewController.h"
#import "SWDProduct.h"
#import "SWDMasterViewController.h"

@interface SWDMapViewController ()

@property (strong, nonatomic) UIImageView *mapView;
@property (strong, nonatomic) SMCalloutView *calloutView;
@property (strong, nonatomic) SWDProduct *selectedProduct;

@property (nonatomic) CGFloat scale;

- (void)renderProducts:(NSArray *)products;
- (void)renderProduct:(SWDProduct *)product tag:(NSUInteger)tag;

@end

@implementation SWDMapViewController
{
    NSMutableArray *_productPins;
    NSInteger _currentIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NOTE: the map scale factor is now hard coded to 0.4, make this according to the zoom-level!!!
    self.scale = 0.4;
    _currentIndex = 0;
    _productPins = [[NSMutableArray alloc] init];
    
    UIImage *map = [UIImage imageNamed:@"kartta-actual-himmee.png"];
    UIImage *checkbox = [UIImage imageNamed:@"19-circle-check.png"];
    UIImage *highlightedCheckbox = [UIImage imageNamed:@"117-todo-white-highlight.png"];
    
    self.calloutView = [[SMCalloutView alloc] init];
    
    if (self.scrollsToCenterPointAfterAppear) {
        self.navigationItem.title = [[self.products objectAtIndex:_currentIndex] valueForKey:@"name"];
    } else {
        UIImageView *checkboxView = [[UIImageView alloc] initWithImage:checkbox highlightedImage:highlightedCheckbox];
        checkboxView.userInteractionEnabled = YES;
        [checkboxView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryViewTapped:)]];
        self.calloutView.rightAccessoryView = checkboxView;
    }
    
    self.mapView = [[UIImageView alloc] initWithImage:map];
    self.mapView.userInteractionEnabled = YES;
    
    // add some padding to the left and top sides of the map
    self.mapView.frame = CGRectMake(0, 65, map.size.width*self.scale, map.size.height*self.scale);
    
    [self.mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped)]];
    
    CGFloat scWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat mpWidth = self.mapView.frame.size.width;
    CGFloat zScale = scWidth / mpWidth;
    
    // add some padding to the right and bottom as well
    self.scrollView.contentSize = CGSizeMake(self.mapView.frame.size.width,
                                             self.mapView.frame.size.height+70);
    self.scrollView.contentMode = UIViewContentModeBottom;
    self.scrollView.minimumZoomScale = zScale;
    self.scrollView.maximumZoomScale = 1.0;
    self.scrollView.delegate = self;
    
    [self.scrollView addSubview:self.mapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self renderProducts:self.products];
    [self showCalloutForPin:[_productPins objectAtIndex:_currentIndex]];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mapView;
}

- (void)renderProducts:(NSArray *)products {
    [[self.mapView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_productPins removeAllObjects];
    
    for (SWDProduct *product in products) {
        [self renderProduct:product tag:[products indexOfObject:product]];
    }
}

- (void)renderProduct:(SWDProduct *)product tag:(NSUInteger)tag
{
    MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil
                                                                             reuseIdentifier:@"productPin"];
    
    pinAnnotationView.center = CGPointMake(product.x.floatValue*self.scale, product.y.floatValue*self.scale);
    pinAnnotationView.pinColor = MKPinAnnotationColorGreen;
    pinAnnotationView.tag = tag;
    
    [pinAnnotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(pinTapped:)]];
    [self.mapView addSubview:pinAnnotationView];
    [_productPins addObject:pinAnnotationView];
}

- (void)showCalloutForPin:(MKPinAnnotationView *)pin
{
    SWDProduct *product = [self.products objectAtIndex:pin.tag];
    
    self.selectedProduct = product;
    self.calloutView.title = product.name;
    self.calloutView.subtitle = [product.price.stringValue stringByAppendingString:@" €"];
    self.calloutView.calloutOffset = pin.calloutOffset;
    
    [self.calloutView presentCalloutFromRect:pin.frame
                                      inView:self.mapView constrainedToView:self.mapView
                    permittedArrowDirections:SMCalloutArrowDirectionAny animated:YES];
    
    [self scrollToCenterProduct:product];
}

- (void)scrollToCenterProduct:(SWDProduct *)product
{
    CGSize fsize = self.scrollView.frame.size;
    CGRect scrollToFrame = CGRectMake(product.x.floatValue*self.scale+5-fsize.width/2,
                                      product.y.floatValue*self.scale+10-fsize.height/2,
                                      fsize.width, fsize.height);
    
    [self.scrollView scrollRectToVisible:scrollToFrame animated:YES];
}

- (void)pinTapped:(UITapGestureRecognizer *)sender
{
    [self showCalloutForPin:(MKPinAnnotationView *)sender.view];
}

- (void)accessoryViewTapped:(UIGestureRecognizer *)gestureRecognizer
{
    [SVProgressHUD showSuccessWithStatus:self.selectedProduct.name];
    
    [self.selectedProduct setCollected: [NSNumber numberWithBool:YES]];
    [self.products removeObject:self.selectedProduct];
    
    [self mapTapped];
    [self renderProducts:self.products];
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
}

- (IBAction)changeCenteredProduct:(UISegmentedControl *)sender {
    NSInteger segment = sender.selectedSegmentIndex;
    if (segment == 0) {
        _currentIndex++;
        if (_currentIndex >= self.products.count)
            _currentIndex = 0;
    }
    if (segment == 1) {
        _currentIndex--;
        if (_currentIndex < 0)
            _currentIndex = self.products.count - 1;
    }
    [self showCalloutForPin:[_productPins objectAtIndex:_currentIndex]];
}

- (void)mapTapped
{
    [self.calloutView dismissCalloutAnimated:YES];
    self.selectedProduct = nil;
}

@end
