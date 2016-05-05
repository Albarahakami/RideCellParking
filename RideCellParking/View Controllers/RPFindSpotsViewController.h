//
//  RPFindSpotsViewController.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RPFindSpotsViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *redoSearchButton;

@end
