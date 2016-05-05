
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
#import "RPSpotConfirmationPopupViewController.h"
#import "UIViewController+CWPopup.h"
#import "RideCellParkingAPI.h"

@interface RPReservationViewController () <RPSpotConfirmationPopupDelegate> {
    
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
    
    // check if we have already made a reservation in the past
    
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
    
    // if not we show the no reservation message by hiding the table view (its behind it hehe)
    else {
        
        [_myTableView setHidden:YES];
        
    }
    
    
}


- (void) viewWillDisappear:(BOOL)animated {
    
    // stop the timer so we don't consume resources
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
    
    // this is to check if the reservation has expired or not
    // If expired, show the lastest reservation details and give the option to reserve
    if (difference <= 0) {
        
        [timeLeftTimer invalidate];
        timeLeftTimer = nil;
        
        [_timeLeftTitleLabel setText:@"Last reservation"];
        [_timeLeftTimerLabel setHidden:YES];
        [_extendLabel setText:@"Reserve again for"];
        [_payButton setTitle:@"Pay & Reserve" forState:UIControlStateNormal];
        
    }
    // If not , show the current reservation details and give the option to extend
    else {
        
        [_timeLeftTitleLabel setText:@"Time left"];
        [_timeLeftTimerLabel setHidden:NO];
        [_extendLabel setText:@"Reserve for"];
        [_payButton setTitle:@"Pay & Extend" forState:UIControlStateNormal];
        [_timeLeftTimerLabel setText:[NSString stringWithFormat:@"%.0f:%.0f", fabs((difference-30)/60.0), fmod(difference, 60.0)]];
        
    }
    
}


- (void) reserveSpot {
    
    // getting the user defaults to save the reservation disctionary
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // this is to check if the reservation has expired or not
    
    NSDate *reservationDate = [reservationData objectForKey:@"reservation_date"];
    NSDate* expirationDate = [reservationDate dateByAddingTimeInterval:[[reservationData objectForKey:@"reservation_duration"] floatValue]*60.0];
    
    NSTimeInterval difference = [expirationDate timeIntervalSinceDate:[NSDate date]];
    
    // if less than 0 that means it has expired so we want to reserve with the new specified period
    if (difference <= 0) {
        
        [reservationData setObject:_extentionTimeLabel.text forKey:@"reservation_duration"];
        
    }
    
    // else we wanna add to our current period
    else {
        
        
        float newDuration = [_extentionTimeLabel.text floatValue] + (difference/60.0);
        
        [reservationData setObject:[NSString stringWithFormat:@"%.0f", newDuration] forKey:@"reservation_duration"];
        
    }
    
    // if you wanna test the last minute of the timer please uncomment this and click pay
//    [reservationData setObject:@"1" forKey:@"reservation_duration"];
    
    
    [reservationData setObject:[NSDate date] forKey:@"reservation_date"];
    
    
    [defaults rm_setCustomObject:reservationData forKey:@"last_reservation"];
    
    [defaults synchronize];
    
    // to update the UI
    
    [self timerFired];
    [timeLeftTimer invalidate];
    timeLeftTimer = nil;
    timeLeftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(timerFired)
                                                   userInfo:nil
                                                    repeats:YES];
    
    
    [RideCellParkingAPI reserveSpot:spot.spot_id
                            minutes:[reservationData objectForKey:@"reservation_duration"]
                            success:nil
                            failure:nil];
    
}


#pragma mark View Button Action

- (IBAction)payClicked:(id)sender {
    
    [self reserveSpot];
    
    RPSpotConfirmationPopupViewController *confirmationViewController = [[RPSpotConfirmationPopupViewController alloc]
                                                                         initWithNibName:@"RPSpotConfirmationPopupViewController"
                                                                         bundle:nil];
    confirmationViewController.delegate = self;
    
    [confirmationViewController setSpot:spot];
    
    [self presentPopupViewController:confirmationViewController
                            animated:YES
                          completion:nil];
    
}

- (IBAction)slideValueChanged:(id)sender {
    
    UISlider *slider = (UISlider*)sender;
    
    // updating the UI with the slider data
    
    [_extentionTimeLabel setText:[NSString stringWithFormat:@"%.0f", slider.value]];
    
    [_totalLabel setText:[NSString stringWithFormat:@"%.2f", slider.value*([spot.cost_per_minute floatValue])]];
}


#pragma mark RPSpotConfirmationPopupDelegate


- (void)viewReservationClickedForSpot:(RPSpot *)spot {
    
    [self dismissPopupViewControllerAnimated:YES
                                  completion:nil];
    
}


- (void)dismissClicked {
    
    [self dismissPopupViewControllerAnimated:YES
                                  completion:nil];
    
}

@end
