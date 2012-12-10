//
//  SWDProductPickerController.m
//  StoreWizDemo
//
//  Created by Sami Kukkonen on 18.11.2012.
//  Copyright (c) 2012 Ilari Kontinen. All rights reserved.
//

#import "SWDProductPickerController.h"

@implementation SWDProductPickerController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWDProduct *product = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if([self.delegate respondsToSelector:@selector(productPickerDidSelectProduct:)]) {
        [self.delegate performSelector:@selector(productPickerDidSelectProduct:) withObject:product];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (IBAction)closeButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
