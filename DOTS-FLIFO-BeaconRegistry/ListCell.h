//
//  ListCell.h
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 3/31/15.
//  Copyright (c) 2015 SITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *departCodeLabel;
@property (nonatomic, weak) IBOutlet UILabel *departCityLabel;
@property (nonatomic, weak) IBOutlet UILabel *flightNbLabel;

@property (nonatomic, weak) IBOutlet UILabel *statusTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) IBOutlet UILabel *gateTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *gateValueLabel;

@property (nonatomic, weak) IBOutlet UILabel *claimTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *claimValueLabel;

@end
