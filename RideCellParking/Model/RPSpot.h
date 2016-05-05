//
//  RPSpot.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPSpot : NSObject

- (id)initWithData:(NSDictionary*)data;

@property (nonatomic, strong) NSString *spot_id;
@property (nonatomic, strong) NSString *cost_per_minute;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *reserved_until;
@property BOOL is_reserved;
@property float lat;
@property float lng;
@property int max_reserve_time_mins;
@property int min_reserve_time_mins;

@end
