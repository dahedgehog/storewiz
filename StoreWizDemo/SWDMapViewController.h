//
//  SWDMapViewController.h
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 21.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMCalloutView.h>

@interface SWDMapViewController : UIViewController <UIScrollViewDelegate, SMCalloutViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (strong, nonatomic) NSMutableArray *products;
@property (nonatomic) BOOL scrollsToCenterPointAfterAppear;
- (IBAction)changeCenteredProduct:(UISegmentedControl *)sender;

@end
