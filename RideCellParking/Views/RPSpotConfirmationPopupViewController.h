//
//  RPSpotConfirmationPopupViewController.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/5/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPSpot.h"


@protocol RPSpotConfirmationPopupDelegate <NSObject>

- (void) payClickedForSpot:(RPSpot*)spot;
- (void) infoClickedForSpot:(RPSpot*)spot;

@end

@interface RPSpotConfirmationPopupViewController : UIViewController

@property (strong, nonatomic) RPSpot *spot;

@property (nonatomic, weak) id delegate;

@property (weak, nonatomic) IBOutlet UILabel *reservationInformationLabel;


@end
