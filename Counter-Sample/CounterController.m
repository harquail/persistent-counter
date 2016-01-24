//
//  CounterController.m
//  Counter-Sample
//
//  Created by nook on 1/21/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import "CounterController.h"

#define MAX_COUNT 10


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

- (void) addCounter{
    [realm transactionWithBlock:^{
        CounterModel * newCounter = [[CounterModel alloc] initWithTitle:@"undefined"];
        // add new counter to top
        [counters.counters insertObject:newCounter atIndex:0];
    }];
    
}

- (void) changeCounterAtIndex:(NSUInteger) index changeAmount:(NSInteger) change{
    [realm transactionWithBlock:^{
        CounterModel * counter = [self counterForIndex:index];
        [counter setValue:counter.value + change];
    }];
}

- (void) incrementCounterAtIndex:(NSUInteger) index{
    [self changeCounterAtIndex:index changeAmount:1];
}

- (void) decrementCounterAtIndex:(NSUInteger) index{
    [self changeCounterAtIndex:index changeAmount:-1];
}

- (CounterModel *) counterForIndex: (NSUInteger) position{
    return [counters.counters objectAtIndex:position];
}

- (NSUInteger) numberOfCounters{
    return counters.counters.count;
}

@end
