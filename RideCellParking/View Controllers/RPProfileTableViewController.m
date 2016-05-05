//
//  RPProfileTableViewController.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/5/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RPProfileTableViewController.h"
#import "RPUser.h"

@interface RPProfileTableViewController ()

@end

@implementation RPProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tabBarController setTitle:@"Profile"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 3) {
        // the sign out method deletes the reservation data
        [RPUser signOut];
        NSLog(@"Deleted reservation data");
        
    }
    
}

@end
