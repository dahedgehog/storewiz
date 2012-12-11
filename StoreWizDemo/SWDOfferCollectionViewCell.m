//
//  SWDOfferCollectionViewCell.m
//  StoreWizDemo
//
//  Created by Tuomas Vuori on 12/11/12.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDOfferCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SWDOfferCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"Rendering...");
    CALayer *layer = self.layer;
    layer.shadowOffset = CGSizeMake(0,3);
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowRadius = 1.5;
    layer.shadowOpacity = 0.7;
    
    CGRect f = CGRectMake(0,0,96.5,96.5);
    layer.shadowPath = [UIBezierPath bezierPathWithRect:f].CGPath;
    [layer setMasksToBounds:NO];
    
    layer.shouldRasterize = YES;
}

@end
