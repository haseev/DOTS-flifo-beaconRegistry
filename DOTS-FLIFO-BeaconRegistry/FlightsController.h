//
//  FlightsController.h
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 3/31/15.
//  Copyright (c) 2015 SITA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FlightsController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *flightsArray;
@property (strong, nonatomic) NSDictionary *flightsData;
@property (strong, nonatomic) UIColor *randAirlineColor;
@property (strong, nonatomic) IBOutlet UITableView *groupedFlightTv;
@property NSString* adInfo;

@end
