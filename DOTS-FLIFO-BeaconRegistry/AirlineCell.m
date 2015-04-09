//
//  AirlineCell.m
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 3/31/15.
//  Copyright (c) 2015 SITA. All rights reserved.
//

#import "AirlineCell.h"

@implementation AirlineCell

- (void)awakeFromNib {
    // Initialization code
    self.randAirlineColor=[UIColor colorWithHue:( arc4random() % 256 / 256.0 ) saturation:( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 128 / 256.0 ) + 0.5 alpha:1];
    
    [self.thumbnailCodeLabel setBackgroundColor:self.randAirlineColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];  
    // Configure the view for the selected state
}

@end
