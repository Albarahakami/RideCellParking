//
//  RideCellParkingAPI.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RideCellParkingAPI.h"
#import "RPUser.h"
#import <NSUserDefaults+RMSaveCustomObject.h>
#import <Crashlytics/Answers.h>

//static NSString * const baseURL = @"http://127.0.0.1:8000/"; //For testing on Local Server
static NSString * const baseURL = @"http://ridecellparking.herokuapp.com/api/v1/parkinglocations/";

@implementation RideCellParkingAPI


+ (void)getParkingLocations:(CLLocationCoordinate2D)coordinates
                    success:(void (^)(id result))success
                    failure:(void (^)(NSError * error ))failure {
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%f", coordinates.latitude],@"lat",
                              [NSString stringWithFormat:@"%f",  coordinates.longitude],@"lng",
                              nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@search/", baseURL]
       parameters:param
          success:^(AFHTTPRequestOperation *op, id response){
              
              if(success){
                  
                  success(response);
                  
              }
              
          }failure:^(AFHTTPRequestOperation *op, NSError *error) {
              
              if (failure) {
                  failure(error);
              }
              
          }];
    
}



@end
