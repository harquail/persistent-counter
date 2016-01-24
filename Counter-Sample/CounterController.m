//
//  CounterController.m
//  Counter-Sample
//
//  Created by nook on 1/21/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import "CounterController.h"

@implementation CounterController
{
@private
    RLMRealm* realm;
    CounterList* counters;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // if a counter list exists, use that. Otherwise, make a new one
        realm = RLMRealm.defaultRealm;
        CounterList* persistedCounters = [[CounterList allObjects] firstObject];
        if(persistedCounters){
            counters = persistedCounters;
        }
        else{
            counters = [[CounterList alloc] init];
            [realm transactionWithBlock:^{
                [realm addObject:counters];
            }];
            
        }
    }
    return self;
}

# pragma mark adding and removing counters

- (void) addCounter{
    [realm transactionWithBlock:^{
        CounterModel * newCounter = [[CounterModel alloc] initWithTitle:@"New Counter"];
        // add new counter to top
        [counters.counters insertObject:newCounter atIndex:0];
    }];
}

# pragma mark modifying counters

- (void) removeCounterAtIndex:(NSUInteger) index{
    [realm transactionWithBlock:^{
        [counters.counters removeObjectAtIndex:index];
    }];
}

- (void) incrementCounterAtIndex:(NSUInteger) index{
    [self changeCounterAtIndex:index changeAmount:1];
}

- (void) decrementCounterAtIndex:(NSUInteger) index{
    [self changeCounterAtIndex:index changeAmount:-1];
}

/// helper function for changing counter values
- (void) changeCounterAtIndex:(NSUInteger) index changeAmount:(NSInteger) change{
    [realm transactionWithBlock:^{
        CounterModel * counter = [self counterForIndex:index];
        [counter setValue:counter.value + change];
    }];
}

- (void) moveCounterAtIndex:(NSUInteger)source toIndex:(NSUInteger)destination{
    [realm transactionWithBlock:^{
        [counters.counters moveObjectAtIndex:source toIndex:destination];
    }];
}

- (void) renameCounterAtIndex:(NSUInteger)index name:(NSString *)newName{
    [realm transactionWithBlock:^{
        CounterModel * counter = [self counterForIndex:index];
        [counter setTitle:newName];
    }];
}

# pragma mark retrieving data

- (CounterModel *) counterForIndex: (NSUInteger) index{
    return [counters.counters objectAtIndex:index];
}

- (NSUInteger) numberOfCounters{
    return counters.counters.count;
}

@end
