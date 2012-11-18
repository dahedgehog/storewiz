//
//  SWDProductViewController.h
//  StoreWizDemo
//
//  Created by Ilari Kontinen on 6.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWDProductItem;
@interface SWDProductViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *adView;
@property (copy, nonatomic) SWDProductItem *product;

@end
