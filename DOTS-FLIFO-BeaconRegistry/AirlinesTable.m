//
//  AirlinesTable.m
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 3/31/15.
//  Copyright (c) 2015 SITA. All rights reserved.
//

#import "AirlinesTable.h"
#import "AirlineCell.h"
#import "FlightsController.h"

@interface AirlinesTable ()

@end

@implementation AirlinesTable

- (void)viewDidLoad {
    [super viewDidLoad];
    self.airlinesTable.delegate = self;
    self.airlinesTable.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrivalsData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"AirlineCell";
    AirlineCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[AirlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *airlineData;
    airlineData = _arrivalsData[indexPath.row];
    
    if (airlineData) {
        cell.nameLabel.text = [airlineData valueForKey:@"airlineName"];
        UIImage *img=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[airlineData valueForKey:@"airlineCode"]]];
        
        if (img) {
            [cell.thumbnailImageView setHidden:false];
            cell.thumbnailImageView.image =img;
            [cell.thumbnailCodeLabel setHidden:true];
         }else{
            
            [cell.thumbnailCodeLabel setHidden:false];
            cell.thumbnailCodeLabel.text = [airlineData valueForKey:@"airlineCode"];
            [cell.thumbnailImageView setHidden:true];
            
       }
         
        int count =[(NSArray*) [airlineData valueForKey:@"flightsArray"] count];
        cell.infoLabel.layer.cornerRadius = 13.0;
        cell.infoLabel.text =[NSString stringWithFormat:@"%d",count];
    }
    
   return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *airlineData;
    airlineData = _arrivalsData[indexPath.row];
  
    if (airlineData) {
        FlightsController *flightsController = [self.storyboard instantiateViewControllerWithIdentifier:@"flightsController"];
        flightsController.flightsArray = [airlineData valueForKey:@"flightsArray"];
        flightsController.flightsData = airlineData;
        flightsController.adInfo = self.adInfo;
        [self.navigationController pushViewController:flightsController animated:YES];
        
    }
}


@end
