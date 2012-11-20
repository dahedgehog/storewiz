//
//  SWDShoppingListMapController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMCalloutView.h>

@interface SWDShoppingListMapController : UIViewController <SMCalloutViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *adView;

@end
