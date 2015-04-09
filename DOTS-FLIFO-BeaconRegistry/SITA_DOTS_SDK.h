//
//  SITA-DOTS-SDK.h
//  SITA-DOTS-SDK
//
//  Created by Bilal Itani on 10/27/14.
//  Copyright (c) 2014 SITA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SITA_DOTS_SDK : NSObject{
    void (^_completionHandler) (NSDictionary *response);
    void (^_completionHandlerDetails) (NSDictionary *response);
    void (^_completionHandlerReport) (int response);
    
    void (^_completionHandlerFlights) (NSDictionary *response);
    void (^_completionHandlerFlightDetails) (NSDictionary *response);
    
}

/*
 *  @brief Allocates and initializes the SITA-DOTS-SDK instance with API info.
 *  @since 1.0
 *
 *  This is the initialization method that will create an instance of the SITA-DOTS-SDK and initializes it with API info: APIkey, flightNumber, AppID, EndPoint, and TimeOut.
 *
 */
- (SITA_DOTS_SDK*)initializeWithAPIParams:(NSString *)APIkey : (NSString *)AppID : (NSString *)EndPoint : (int)TimeOut;

/*
 *  @brief Initializes the SITA-DOTS-SDK instance's flight info.
 *  @since 1.0
 *
 *  This is a mandatory method that sets the SITA-DOTS-SDK flight info: airportCode, flightNumber, flightDate, and flightDate.
 *  @note This method must be called prior to invoking getBeacons:, getBeaconDetails:, addBeaconsLog:, and postBeaconsLogToServer .
 *
 */
- (void)setFlightInfo: (NSString *)airportCode : (NSString *)flightNumber : (NSString *)flightDate : (NSString *)paxName;

/*
 *  @brief Gets available beacons at an airport.
 *  @since 1.0
 *
 *  This method gets a list of available beacons at a selected airport code, it accepts airport code as input and returns a NSDictionary of beacons, response can be retrieved from the completion handler of this method, if airportCode is nil then the airportcode set in method setFlightInfo: will be used.
 *
 */
- (void)getBeacons:(NSString *)airportCode :(void (^) (NSDictionary *response))handler;

/*
 *  @brief Gets a beacon's details.
 *  @since 1.0
 *
 *  This method gets the details of a beacon from registry, it accepts beacon's UUID, major, minor, and rssi code as inputs and returns a NSDictionary of beacon details, response can be retrieved from the completion handler of this method.
 *
 */
- (void)getBeaconDetails:(NSString *)UUID : (NSString *)major : (NSString *)minor : (int)rssi :(void (^) (NSDictionary *response))handler;

/*
 *  @brief Stores a log for a beacon.
 *  @since 1.0
 *
 *  This method accepts an Array of beacon objects (CLBeacon) and locally stores a log for every beacon, later these logs can be posted to API via the postBeaconsLogToServer method.
 *
 */
- (void)beaconDetectionLog:(NSArray *)beaconsArray;

/*
 *  @brief Posts locally stored beacons logs to API.
 *  @since 1.0
 *
 *  This method will post the locally stored beacons logs to API, on success response value will be "200", response can be retrieved from the completion handler of this method.
 *
 */
- (void) beaconDetectionReport:(void (^) (int response))handler;

/*
 *  @brief Allocates and initializes the FLIFO API calls with required API info.
 *  @since 1.0
 *
 *  This is the initialization method that will initialize the SDK with required FLIFO API info: FLIFOEndPointURL, FLIFOAPIkey, FLIFODetailsURL.
 *
 */
- (void)setFlifoApiInfo: (NSString *)FLIFOEndPointURL : (NSString *)FLIFODetailsURL : (NSString *)FLIFOAPIKey;

/*
 *  @brief Gets all flights at a given airport.
 *  @since 1.0
 *
 *  This method gets the list of flights at a given airport, flights can be retrieved by either by airport code or by airport code and airline code, in case no airline code is specified, the flight list will contain all flights at selected airport, method accepts FLIFOAirportCode, FLIFOAirlineCode, arrival/departure flag and returns a NSDictionary of flight list, response can be retrieved from the completion handler of this method.
 *
 */
- (void)getFlights: (NSString *)FLIFOAirportCode : (NSString *)FLIFOAirlineCode :(NSString *)adi :(void (^) (NSDictionary *response))handler;

/*
 *  @brief Gets a single flight details.
 *  @since 1.0
 *
 *  This method gets the details of a single flight, method accepts FLIFOAirportCode, FLIFOAirlineCode, flightNumber, arrival/departure flag and returns a NSDictionary of flight details, response can be retrieved from the completion handler of this method.
 *
 */
- (void)getFlightDetails: (NSString *)FLIFOAirportCode : (NSString *)FLIFOAirlineCode : (NSString *)flightNumber :(NSString *)adi :(void (^) (NSDictionary *response))handler;

@end
