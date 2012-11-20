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
    static NSString *CellIdentifier = @"ProductPickerCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.indentationLevel = 3;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [button addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchDown];
        button.frame = CGRectMake(10.0, 10.0, 25.0, 25.0);
        [cell addSubview:button];
    }
    
    SWDProductItem *product = [self.searched objectAtIndex:indexPath.row];
    cell.textLabel.text = product.label;
    cell.detailTextLabel.text = [product.price stringByAppendingString:@" €"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowProductView" sender:self];
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
