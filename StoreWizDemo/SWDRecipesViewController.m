//
//  SWDRecipesViewController.m
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 22.1.2013.
//  Copyright (c) 2013 Ilari Kontinen. All rights reserved.
//

#import "SWDRecipesViewController.h"

@interface SWDRecipesViewController ()

@end

@implementation SWDRecipesViewController

- (IBAction)addButtonTapped:(id)sender {
    [SVProgressHUD showSuccessWithStatus:@"Resepti lisätty ostoskoriin."];
}

@end
