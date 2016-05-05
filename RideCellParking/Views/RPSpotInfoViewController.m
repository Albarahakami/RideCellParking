//
//  RPSpotInfoViewController.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/5/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RPSpotInfoViewController.h"

@interface RPSpotInfoViewController ()

@end

@implementation RPSpotInfoViewController

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
    
    [_nameLabel setText:spot.name];
    [_costLabel setText:[NSString stringWithFormat:@"%@/min", spot.cost_per_minute]];
    [_distanceLabel setText:@".5 miles"];
    [_openSpotsLabel setText:@"2 spots"];
    
}


- (IBAction)payButtonClicked:(id)sender {
    
    [self.delegate payClickedForSpot:_spot];
    
}

- (IBAction)infoButtonClicked:(id)sender {
    
    [self.delegate infoClickedForSpot:_spot];
    
}

@end
