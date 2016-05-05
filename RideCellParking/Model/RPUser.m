//
//  RPUser.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RPUser.h"
#import <NSUserDefaults+RMSaveCustomObject.h>

@implementation RPUser


- (id)initWithSelf
{
    self = [super init];
    if (self) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *myUserData = [userDefaults rm_customObjectForKey:@"userData"];
        
        _user_id = [myUserData objectForKey:@"user_id"];
        _username = [myUserData objectForKey:@"username"];
        _email = [myUserData objectForKey:@"email"];
        _phone_number = [myUserData objectForKey:@"phone_number"];
        _access_token = myUserData[@"access_token"];
        
    }
    
    return self;
}


+ (BOOL)isSignedIn {
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *myUserData = [defaults rm_customObjectForKey:@"userData"];
    
    return myUserData;
}


+ (void)signOut {
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"any"];
    [defaults removeObjectForKey:@"user"];
    [defaults removeObjectForKey:@"related"];
    [defaults removeObjectForKey:@"data"];
    [defaults removeObjectForKey:@"userData"];
    [defaults removeObjectForKey:@"last_reservation"];
    [defaults synchronize];
    
}


@end
