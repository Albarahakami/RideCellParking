//
//  RPReservationsViewController.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPReservationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (weak, nonatomic) IBOutlet UILabel *timeLeftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *extendLabel;
@property (weak, nonatomic) IBOutlet UILabel *extentionTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
