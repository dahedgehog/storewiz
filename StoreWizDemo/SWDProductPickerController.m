//
//  SWDProductPickerController.m
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 18.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductPickerController.h"

@interface SWDProductPickerController ()

@end

@implementation SWDProductPickerController

@synthesize delegate;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWDProduct *product = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if([delegate respondsToSelector:@selector(productPickerDidSelectProduct:)]) {
        [delegate performSelector:@selector(productPickerDidSelectProduct:) withObject:product];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (IBAction)closeButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
