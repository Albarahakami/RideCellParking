//
//  RPSpotConfirmationPopupViewController.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/5/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RPSpotConfirmationPopupViewController.h"

@interface RPSpotConfirmationPopupViewController ()

@end

@implementation RPSpotConfirmationPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setSpot:(RPSpot *)spot {
    
    _spot = spot;
    
    [_reservationInformationLabel setText:[NSString stringWithFormat:@"You've reserved %@", spot.name]];
    
}



- (IBAction)viewReservationClicked:(id)sender {
    
    [self.delegate viewReservationClickedForSpot:_spot];
    
}

- (IBAction)dismissClicked:(id)sender {
    
    [self.delegate dismissClicked];
    
}


@end
