//
//  RPSpot.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RPSpot.h"

@implementation RPSpot


- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _spot_id = [[data objectForKey:@"id"] stringValue];
        _cost_per_minute = [data objectForKey:@"cost_per_minute"];
        _name = [data objectForKey:@"name"];
        _reserved_until = [data objectForKey:@"reserved_until"];
        _is_reserved = [[data objectForKey:@"is_reserved"] boolValue];
        _lat = [[data objectForKey:@"lat"] floatValue];
        _lng = [[data objectForKey:@"lng"] floatValue];
        _max_reserve_time_mins = [[data objectForKey:@"max_reserve_time_mins"] intValue];
        _min_reserve_time_mins = [[data objectForKey:@"min_reserve_time_mins"] intValue];
        
    }
    
    return self;
    
}

@end
