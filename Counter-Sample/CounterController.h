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

@interface CounterController : NSObject

- (NSUInteger) numberOfCounters;
- (void) addCounter;
- (void) removeCounterAtIndex: (NSUInteger) index;
- (CounterModel *) counterForIndex: (NSUInteger) index;
- (void) incrementCounterAtIndex:(NSUInteger) index;
- (void) decrementCounterAtIndex:(NSUInteger) index;
- (void) moveCounterAtIndex:(NSUInteger) source toIndex: (NSUInteger) destination;
- (void) renameCounterAtIndex:(NSUInteger) index name:(NSString *) newName;

@end
