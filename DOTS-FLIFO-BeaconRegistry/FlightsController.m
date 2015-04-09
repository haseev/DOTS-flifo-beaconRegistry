//
//  FlightsController.m
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 3/31/15.
//  Copyright (c) 2015 SITA. All rights reserved.
//

#import "FlightsController.h"
#import "ListCell.h"
#import "Constants.h"
#import "SITA_DOTS_SDK.h"

@interface FlightsController ()

@end

@implementation FlightsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.groupedFlightTv.delegate = self;
    self.groupedFlightTv.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _flightsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ListCell";
    
    ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
    NSDictionary *flightData=_flightsArray[indexPath.row];
    
    if (flightData) {
        
        NSDictionary *operatingCarrier=[flightData valueForKey:@"operatingCarrier"];
        
        if ([flightData valueForKey:@"airportCode"]) {
            NSString *text=@"";
            if ([[self.adInfo lowercaseString]isEqualToString:@"a"])
                text=@"arriving from" ;
        
            else
                text=@"departing to" ;
            
            
            cell.departCodeLabel.text =[NSString stringWithFormat:@"%@ %@",text,[flightData valueForKey:@"airportCode"]];
        }
        
        if ([flightData valueForKey:@"city"]) {
            NSMutableString *airportCityStr=[[NSMutableString alloc] init];
            NSArray *strArray=[[[flightData valueForKey:@"city"] lowercaseString] componentsSeparatedByString:@" "];
            
            for (int x=0; x<strArray.count; x++) {
                if (x>0) {
                    [airportCityStr appendString:@" "];
                }
                
                [airportCityStr appendFormat:@"%@%@",[[strArray[x] substringToIndex:1] uppercaseString],[strArray[x] substringFromIndex:1]];
            }
            
            cell.departCityLabel.text =airportCityStr;
        }
        
        if ([operatingCarrier valueForKey:@"flightNumber"]) {
            cell.flightNbLabel.text = [operatingCarrier valueForKey:@"flightNumber"];
        }
        
        
        if ([flightData valueForKey:@"gate"]) {
            cell.gateValueLabel.text = [flightData valueForKey:@"gate"];
        }else{
            [cell.gateTitleLabel removeFromSuperview];
        }
        
        if ([flightData valueForKey:@"claim"]) {
            cell.claimValueLabel.text = [flightData valueForKey:@"claim"];
        }else{
            [cell.claimTitleLabel removeFromSuperview];
        }
        
        
        if (![[flightData valueForKey:@"status"] isEqualToString:@"UN"] && ![[flightData valueForKey:@"status"] isEqualToString:@"DP"]) {
            cell.statusTextLabel.text = [flightData valueForKey:@"statusText"];
            
            if ([[flightData valueForKey:@"status"] isEqualToString:@"ON"]) {
                [cell.statusTextLabel setTextColor:[UIColor blueColor]];
            }else if ([[flightData valueForKey:@"status"] isEqualToString:@"DL"]) {
                [cell.statusTextLabel setTextColor:[UIColor redColor]];
            }
        }
        
        NSDate *arrivalDate=nil;
        NSString *dateStr;
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
        
        if ([flightData valueForKey:@"actual"]) {
            arrivalDate=[dateFormat dateFromString:[flightData valueForKey:@"actual"]];
            dateStr= [flightData valueForKey:@"actual"];
        }else if ([flightData valueForKey:@"scheduled"]) {
            arrivalDate=[dateFormat dateFromString:[flightData valueForKey:@"scheduled"]];
            dateStr=[flightData valueForKey:@"scheduled"];
        }else if ([flightData valueForKey:@"estimated"]) {
            arrivalDate=[dateFormat dateFromString:[flightData valueForKey:@"estimated"]];
            dateStr=[flightData valueForKey:@"estimated"];
        }
        
        if (arrivalDate) {
            cell.timeLabel.text = [dateStr substringWithRange:NSMakeRange(11, 5)];
        }
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *flightInfo=_flightsArray[indexPath.row];
    
    if (flightInfo) {
     
        NSDictionary *operatingCarrier=[flightInfo valueForKey:@"operatingCarrier"];
        
        NSString *airportCode = @"";
        NSString *airlineCode = @"";
        NSString *flightNumber = @"";
        NSString *adi = @"";
        
         if ([self.flightsData valueForKey:@"airportCode"])
            airportCode = [self.flightsData valueForKey:@"airportCode"];
        
        
        if ([operatingCarrier valueForKey:@"flightNumber"])
            flightNumber = [operatingCarrier valueForKey:@"flightNumber"];
       
        if ([operatingCarrier valueForKey:@"airlineCode"])
            airlineCode = [operatingCarrier valueForKey:@"airlineCode"];
        
        if ([self.flightsData valueForKey:@"adi"])
            adi = [self.flightsData valueForKey:@"adi"];
        
        
        
        [[AppDelegate sharedAppDelegate].SITA_DOTS_SDKObject getFlightDetails:airportCode :airlineCode :flightNumber :adi :^(NSDictionary* response){
           if ([[response objectForKey:@"flightDetails"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *flightInfo = [response objectForKey:@"flightDetails"];
                NSData *data = [NSJSONSerialization dataWithJSONObject:flightInfo options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonStr = [[NSString alloc] initWithData:data
                                                         encoding:NSUTF8StringEncoding];
               
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:jsonStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               
                [alert show];
               
             }
        }];
   }
}

@end
