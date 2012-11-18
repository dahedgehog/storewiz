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
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.indentationLevel = 3;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(10.0, 10.0, 25.0, 25.0);
    [cell addSubview:button];
    
    return cell;
}

- (void)addButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell *)button.superview];
    SWDProductItem *product = [self.searched objectAtIndex:index.row];
    if([delegate respondsToSelector:@selector(productSelected:)]) {
        [delegate productSelected:product];
    }
}

- (IBAction)closeButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
