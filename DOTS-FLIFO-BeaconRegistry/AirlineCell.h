//
//  AirlineCell.h
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 3/31/15.
//  Copyright (c) 2015 SITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirlineCell : UITableViewCell

@property (strong, nonatomic) UIColor *randAirlineColor;
@property (nonatomic, weak) IBOutlet UILabel *thumbnailCodeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;

@end
