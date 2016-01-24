//
//  CounterTableViewCell.h
//  Counter-Sample
//
//  Created by nook on 1/23/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@end

@implementation CounterTableViewCell
@end