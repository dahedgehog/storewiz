//
//  SWDMapViewController.h
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 21.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMCalloutView.h>

@interface SWDMapViewController : UIViewController <SMCalloutViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *adView;

@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSMutableArray *collectedProducts;

@end
