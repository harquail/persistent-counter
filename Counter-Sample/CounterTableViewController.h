//
//  CounterTableViewController.h
//  Counter-Sample
//
//  Created by nook on 1/20/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CounterController.h"

@interface CounterTableViewController : UITableViewController <UITableViewDataSource>

@property CounterController* counterController;

@end
