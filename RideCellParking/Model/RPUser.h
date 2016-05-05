//
//  RPUser.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPUser : NSObject

- (id)initWithSelf;

+ (BOOL) isSignedIn;
+ (void) signOut;

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone_number;
@property (nonatomic, strong) NSString *access_token;

@end
