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
- (CounterModel *) counterForIndex: (NSUInteger) position;
- (void) incrementCounterAtIndex:(NSUInteger) index;
- (void) decrementCounterAtIndex:(NSUInteger) index;


//= RLMRealm.defaultRealm;

@end
