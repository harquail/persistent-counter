//
//  CounterTableViewController.m
//  Counter-Sample
//
//  Created by nook on 1/20/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import "CounterTableViewController.h"
#import "CounterTableViewCell.h"
#import "CounterController.h"

@implementation CounterTableViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.counterController = [[CounterController alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // hack bc storyboard edit button does not change to done automatically
    // https://stackoverflow.com/questions/7921579/iphone-storyboard-editing-a-table-view
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

# pragma mark handling button presses

- (IBAction)editPressed:(UIBarButtonItem *)sender {
    (self.tableView.isEditing) ? [self.tableView setEditing:NO animated:YES] : [self.tableView setEditing:YES animated:YES];
}

- (IBAction)addPressed:(UIBarButtonItem *)sender {
    [self.counterController addCounter];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Name this counter" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    // delete newest counter if 'cancel'; if 'ok', rename the counter
    void (^addHandler)(UIAlertAction *action) = ^void(UIAlertAction *action){
        switch (action.style) {
            case UIAlertActionStyleDefault:
                [self.counterController renameCounterAtIndex:0 name: alert.textFields.firstObject.text];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                break;
            case UIAlertActionStyleCancel:
                [self.counterController removeCounterAtIndex:0];
                [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            default:
                break;
        }

    };
    
    UIAlertAction * save = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:addHandler];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:addHandler];
    [alert addAction:save];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         // TODO: grab existing text from counter rather than rewriting again here
         textField.text = @"New Counter";
     }];
    
    // prevents autolayout error
    [alert.view setNeedsLayout];
    
    [self presentViewController:alert animated:YES completion:nil];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)segmentedControlPressed:(UISegmentedControl *)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    // 0 if decrement, 1 if increment
    NSInteger index = sender.selectedSegmentIndex;
    (index) ? [self.counterController incrementCounterAtIndex:indexPath.row] : [self.counterController decrementCounterAtIndex:indexPath.row];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

# pragma mark table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.counterController.numberOfCounters;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CounterModel * counter = [self.counterController counterForIndex:indexPath.row];
    
    CounterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"counter-cell"];
    [cell.titleLabel setText:counter.title];
    [cell.valueLabel setText:[NSString stringWithFormat:@"%ld",(long)counter.value]];

    return cell;
}

# pragma mark table view editing functions

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            [self.counterController removeCounterAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self.counterController moveCounterAtIndex:sourceIndexPath.row toIndex: destinationIndexPath.row];
}


@end
