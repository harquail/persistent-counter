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

@property NSInteger value;
@property NSString *title;

- (instancetype)initWithTitle:(NSString*) title;

@end

RLM_ARRAY_TYPE(CounterModel)
@interface CounterList : RLMObject

@property RLMArray<CounterModel *><CounterModel> *counters;

@property NSInteger realmKey;

@end
