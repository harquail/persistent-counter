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


- (IBAction)editPressed:(UIBarButtonItem *)sender {
    (self.tableView.isEditing) ? [self.tableView setEditing:NO animated:YES] : [self.tableView setEditing:YES animated:YES];
}

- (IBAction)addPressed:(UIBarButtonItem *)sender {
    [self.counterController addCounter];
    [[self tableView] reloadData];
}
- (IBAction)segmentedControlPressed:(UISegmentedControl *)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    // 0 if decrement, 1 if increment
    NSInteger index = sender.selectedSegmentIndex;
    (index) ? [self.counterController incrementCounterAtIndex:indexPath.row] : [self.counterController decrementCounterAtIndex:indexPath.row];
    
    [self.tableView reloadData];

}

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


@end
