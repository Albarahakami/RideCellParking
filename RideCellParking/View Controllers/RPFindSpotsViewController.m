//
//  RPFindSpotsViewController.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RPFindSpotsViewController.h"
#import "RideCellParkingTools.h"
#import "RideCellParkingAPI.h"
#import "RPSpotInfoViewController.h"
#import "RPSpot.h"

#define SEARCH_VIEW_VISIBLE_AREA_HIEGHT 25

@interface RPFindSpotsViewController () <SpotInfoPopupDelegate> {
    
    
    RPSpotInfoViewController *infoViewController;
    NSMutableArray *spots;
    
    BOOL isSearchViewPulledDown;
    BOOL didSearchFirstTime;
    
}

@end

@implementation RPFindSpotsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    infoViewController = [[RPSpotInfoViewController alloc]
                          initWithNibName:@"RPSpotInfoViewController"
                          bundle:nil];
    infoViewController.delegate = self;
    
    spots = [[NSMutableArray alloc] init];
    
    isSearchViewPulledDown = YES;
    
    
    [self.myMapView.camera setCenterCoordinate:CLLocationCoordinate2DMake(37.781471, -122.460083)];
    [self.myMapView.camera setAltitude:5500];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark Controller Specific Method


- (void) refreshResults {
    
    [_myMapView removeAnnotations:_myMapView.annotations];
    spots = [[NSMutableArray alloc] init];
    
    [RideCellParkingAPI getParkingLocations:_myMapView.centerCoordinate
                                    success:^(id result) {
                                        
//                                        NSLog(@"%@", result);
                                        
                                        
                                        for (int i = 0; i < ((NSArray*)result).count; i++) {
                                            
                                            RPSpot *spot = [[RPSpot alloc] initWithData:result[i]];
                                            [spots addObject:spot];
                                            
                                            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                                            [annotation setCoordinate:CLLocationCoordinate2DMake(spot.lat, spot.lng)];
                                            [self.myMapView addAnnotation:annotation];
                                            
                                            if (i == 0) {
                                                
                                                [self.myMapView.camera setCenterCoordinate:annotation.coordinate];
                                                [self.myMapView.camera setAltitude:5500];
                                                
                                            }
                                            
                                        }
                                        
                                        
                                        didSearchFirstTime = YES;
                                        
                                        
                                    }
                                    failure:^(NSError *error) {
                                        
                                        NSLog(@"%@", error);
                                        
                                    }];
    
}


- (void) toggleSearchView {
    
    if (isSearchViewPulledDown) {
        
        [self hideSearchView];
        
    }
    else {
        
        [self showSearchView];
        
    }
    
}


- (void) hideSearchView {
    
    isSearchViewPulledDown = NO;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [_searchView setFrame:CGRectMake(_searchView.frame.origin.x,
                                                          -(_searchView.frame.size.height-SEARCH_VIEW_VISIBLE_AREA_HIEGHT),
                                                          _searchView.frame.size.width,
                                                          _searchView.frame.size.height)];
                         
    }];
    
}


- (void) showSearchView {
    
    isSearchViewPulledDown = YES;
    [_redoSearchButton setHidden:YES];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [_searchView setFrame:CGRectMake(_searchView.frame.origin.x,
                                                          0,
                                                          _searchView.frame.size.width,
                                                          _searchView.frame.size.height)];
                         
                     }];
    
}


#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc]
                                           initWithAnnotation:annotation
                                           reuseIdentifier:@"pin"];
    [annotationView setAnimatesDrop:YES];
    
    return annotationView;
    
}

- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view {
    
    [self.myMapView.camera setCenterCoordinate:view.annotation.coordinate];
    [self.myMapView.camera setAltitude:1500];
    
    
    
    for (int i = 0; i < spots.count; i++) {
        
        if (view.annotation.coordinate.latitude == ((RPSpot*)spots[i]).lat
            && view.annotation.coordinate.longitude == ((RPSpot*)spots[i]).lng) {
            
            [infoViewController setSpot:spots[i]];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [infoViewController.view setCenter:CGPointMake(self.myMapView.center.x,
                                                               self.myMapView.center.y - infoViewController.view.frame.size.height)];
                
            }];
            
            [self.view addSubview:infoViewController.view];
            
            break;
            
        }
        
    }

    
    [_redoSearchButton setHidden:YES];
    [infoViewController.view setHidden:NO];
    
}


- (void)mapView:(MKMapView *)mapView
regionWillChangeAnimated:(BOOL)animated {
    
    if (didSearchFirstTime) {
        
        [_redoSearchButton setHidden:NO];
        [self hideSearchView];
        [infoViewController.view setHidden:YES];
        self.myMapView.selectedAnnotations = @[];
        
    }
    
    
    
}


#pragma mark View Button Action

- (IBAction)searchClicked:(id)sender {
    
    [self hideSearchView];
    [self refreshResults];
    
}

- (IBAction)toggleSearchViewClicked:(id)sender {
    
    [self toggleSearchView];
    
}

- (IBAction)sliderValueChanged:(id)sender {
    
    UISlider *slider = (UISlider*)sender;
    
    [_totalTimeLabel setText:[NSString stringWithFormat:@"%.0f min", slider.value]];
    
}


- (IBAction)redoSearchButtonClicked:(id)sender {
    
    [self refreshResults];
    [_redoSearchButton setHidden:YES];
    
}



#pragma mark SpotInfoPopupDelegate

- (void)payClickedForSpot:(RPSpot *)spot {
    
    [infoViewController.view setHidden:YES];
    
}

- (void)infoClickedForSpot:(RPSpot *)spot {
    
    [infoViewController.view setHidden:YES];
    
}


@end
