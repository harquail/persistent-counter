//
//  CounterModel.h
//  Counter-Sample
//
//  Created by nook on 1/21/16.
//  Copyright © 2016 nook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface CounterModel : RLMObject

/// the counter's number, starts at zero
@property NSInteger value;
/// the counters name
@property NSString *title;

- (instancetype)initWithTitle:(NSString*) title;

@end

// realm black magic
RLM_ARRAY_TYPE(CounterModel)

@interface CounterList : RLMObject

/// a persistant mutable array of counters
@property RLMArray<CounterModel *><CounterModel> *counters;
/// key required by realm
@property NSInteger realmKey;

@end
