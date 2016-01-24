//
//  CounterModel.m
//  Counter-Sample
//
//  Created by nook on 1/23/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CounterModel.h"

/// a counter has a name and a numerical value
@implementation CounterModel

- (instancetype)initWithTitle:(NSString*) title
{
    self = [super init];
    if (self) {
        self.value = 0;
        self.title = title;
    }
    return self;
}

@end

/// the list of all counters — persisted to realm
@implementation CounterList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.counters = [[RLMArray<CounterModel> alloc] initWithObjectClassName:[CounterModel className]];
        // every counterList has the same realm key, ensuring we only have one persisted in realm
        self.realmKey = 0;
    }
    return self;
}

+ (NSString *)primaryKey {
    return @"realmKey";
}

@end
