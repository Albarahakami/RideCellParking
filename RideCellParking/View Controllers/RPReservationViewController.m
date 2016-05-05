
//
//  RPReservationsViewController.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RPReservationViewController.h"
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "RPSpot.h"

@interface RPReservationViewController () {
    
    RPSpot *spot;
    NSTimer *timeLeftTimer;
    NSMutableDictionary *reservationData;
    
}

@end

@implementation RPReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tabBarController setTitle:@"Reservation"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    reservationData = [defaults rm_customObjectForKey:@"last_reservation"];
    
    if (reservationData) {
        
        [_myTableView setHidden:NO];
        
        spot = [reservationData objectForKey:@"spot"];
        [_nameLabel setText:spot.name];
        
        [self timerFired];
        
        timeLeftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(timerFired)
                                                       userInfo:nil
                                                        repeats:YES];
        
    }
    else {
        
        [_myTableView setHidden:YES];
        
    }
    
    
}


- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [timeLeftTimer invalidate];
    timeLeftTimer = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Controller Specific Method

- (void) timerFired {
    
    NSDate *reservationDate = [reservationData objectForKey:@"reservation_date"];
    NSDate* expirationDate = [reservationDate dateByAddingTimeInterval:[[reservationData objectForKey:@"reservation_duration"] floatValue]*60.0];
    
    NSTimeInterval difference = [expirationDate timeIntervalSinceDate:[NSDate date]];
    
//    if (difference > 120) {
//        difference = 0;
//    }
    
    if (difference <= 0) {
        
        [timeLeftTimer invalidate];
        timeLeftTimer = nil;
        
        [_timeLeftTitleLabel setText:@"Last reservation"];
        [_timeLeftTimerLabel setHidden:YES];
        [_extendLabel setText:@"Reserve again for"];
        [_payButton setTitle:@"Pay & Reserve" forState:UIControlStateNormal];
        
    }
    else {
        
        [_timeLeftTitleLabel setText:@"Time left"];
        [_timeLeftTimerLabel setHidden:NO];
        [_extendLabel setText:@"Reserve for"];
        [_payButton setTitle:@"Pay & Extend" forState:UIControlStateNormal];
        [_timeLeftTimerLabel setText:[NSString stringWithFormat:@"%.0f:%.0f", fabs((difference-30)/60.0), fmod(difference, 60.0)]];
        
    }
    
}


- (void) reserveSpot {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSDate *reservationDate = [reservationData objectForKey:@"reservation_date"];
    NSDate* expirationDate = [reservationDate dateByAddingTimeInterval:[[reservationData objectForKey:@"reservation_duration"] floatValue]*60.0];
    
    NSTimeInterval difference = [expirationDate timeIntervalSinceDate:[NSDate date]];
    
    if (difference <= 0) {
        
        [reservationData setObject:_extentionTimeLabel.text forKey:@"reservation_duration"];
        
    }
    else {
        
        float newDuration = [_extentionTimeLabel.text floatValue] + (difference/60.0);
        
        [reservationData setObject:[NSString stringWithFormat:@"%.0f", newDuration] forKey:@"reservation_duration"];
        
    }
    
    
    [reservationData setObject:@"1" forKey:@"reservation_duration"];
    
    [reservationData setObject:[NSDate date] forKey:@"reservation_date"];
    
    
    [defaults rm_setCustomObject:reservationData forKey:@"last_reservation"];
    
    [defaults synchronize];
    
    
    [self timerFired];
    [timeLeftTimer invalidate];
    timeLeftTimer = nil;
    timeLeftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(timerFired)
                                                   userInfo:nil
                                                    repeats:YES];
    
}


#pragma mark View Button Action

- (IBAction)payClicked:(id)sender {
    
    [self reserveSpot];
    
}

- (IBAction)slideValueChanged:(id)sender {
    
    UISlider *slider = (UISlider*)sender;
    
    [_extentionTimeLabel setText:[NSString stringWithFormat:@"%.0f", slider.value]];
    
    [_totalLabel setText:[NSString stringWithFormat:@"%.2f", slider.value*([spot.cost_per_minute floatValue])]];
}

@end
