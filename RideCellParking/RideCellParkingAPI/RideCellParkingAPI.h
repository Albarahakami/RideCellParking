//
//  RideCellParkingAPI.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking/AFURLSessionManager.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RideCellParkingAPI : NSObject


+ (void)getParkingLocations:(CLLocationCoordinate2D)coordinates
                    success:(void (^)(id result))success
                    failure:(void (^)(NSError * error ))failure;


@end
