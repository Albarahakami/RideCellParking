//
//  RPSpotInfoViewController.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/5/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPSpot.h"


@protocol SpotInfoPopupDelegate <NSObject>

- (void) payClickedForSpot:(RPSpot*)spot;
- (void) infoClickedForSpot:(RPSpot*)spot;

@end


@interface RPSpotInfoViewController : UIViewController

@property (strong, nonatomic) RPSpot *spot;

@property (nonatomic, weak) id delegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *openSpotsLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
