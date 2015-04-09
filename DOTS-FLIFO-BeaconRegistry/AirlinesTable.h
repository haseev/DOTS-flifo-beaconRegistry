//
//  AirlinesTable.h
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 3/31/15.
//  Copyright (c) 2015 SITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirlinesTable : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *airlinesTable;
@property NSMutableArray *arrivalsData;
@property NSString *adInfo;

@end
