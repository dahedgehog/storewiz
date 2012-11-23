//
//  SWDViewController.m
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDMasterViewController.h"

@interface SWDMasterViewController ()

@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *imageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

@end

@implementation SWDMasterViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *cityImage = [UIImage imageNamed:@"citymarket_logo.png"];
    UIImageView *iView = [[UIImageView alloc] initWithImage:cityImage];
    self.navigationItem.titleView = iView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageImages = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"city_loytoja.png"],
                       [UIImage imageNamed:@"city_loytoja.png"],
                       [UIImage imageNamed:@"city_loytoja.png"],
                       [UIImage imageNamed:@"city_loytoja.png"],
                       nil];
    
    NSInteger pageCount = self.pageImages.count;
    
    self.imagePager.currentPage = 0;
    self.imagePager.numberOfPages = pageCount;
    
    self.imageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; i++) {
        [self.imageViews addObject:[NSNull null]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGSize scrollerSize = self.imageScroller.frame.size;
    self.imageScroller.contentSize = CGSizeMake(self.pageImages.count * scrollerSize.width, scrollerSize.height);
    
    [self loadVisiblePages];
}

# pragma mark - landing page ad scroller

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadVisiblePages];
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        return;
    }
    
    UIView *imageView = [self.imageViews objectAtIndex:page];
    if ((NSNull *)imageView == [NSNull null]) {
        CGRect frame = self.imageScroller.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        UIImageView *newImageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        newImageView.contentMode = UIViewContentModeScaleToFill;
        newImageView.frame = frame;
        
        [self.imageScroller addSubview:newImageView];
        [self.imageViews replaceObjectAtIndex:page withObject:newImageView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        return;
    }

    UIView *imageView = [self.imageViews objectAtIndex:page];
    if ((NSNull *)imageView != [NSNull null]) {
        [imageView removeFromSuperview];
        [self.imageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)loadVisiblePages {
    CGFloat scrollWidth = self.imageScroller.frame.size.width;
    NSInteger page = (NSInteger)floor(self.imageScroller.contentOffset.x * 2.0f + scrollWidth) / (scrollWidth * 2.0f);
    
    self.imagePager.currentPage = page;
    
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i = 0; i < firstPage; i++) {
        [self purgePage:i];
    }
    
    for (NSInteger i = firstPage; i <= lastPage; i++) {
        [self loadPage:i];
    }
    
    for (NSInteger i = lastPage+1; i < self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

@end
