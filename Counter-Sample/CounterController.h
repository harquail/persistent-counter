//
//  CounterController.h
//  Counter-Sample
//
//  Created by nook on 1/21/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "CounterModel.h"

/// adds, deletes, and persists counters
@interface CounterController : NSObject

/// make a new counter at index 0
- (void) addCounter;
/// delete counter
- (void) removeCounterAtIndex: (NSUInteger) index;

/// increase counter value by 1
- (void) incrementCounterAtIndex:(NSUInteger) index;
/// decrease counter value by 1
- (void) decrementCounterAtIndex:(NSUInteger) index;

/// change title of counter
- (void) renameCounterAtIndex:(NSUInteger) index name:(NSString *) newName;
/// move counter in the list
- (void) moveCounterAtIndex:(NSUInteger) source toIndex: (NSUInteger) destination;

/// get the counter at an index
- (CounterModel *) counterForIndex: (NSUInteger) index;
/// total # of counters
- (NSUInteger) numberOfCounters;

@end
