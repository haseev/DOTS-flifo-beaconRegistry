//
//  Constants.h
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Bilal Itani on 11/11/14.
//  Copyright (c) 2014 ITXi. All rights reserved.
//


//Beacon API INFO
#define BeaconRegistryAPIKey   @"YOUR_BEACON_REGISTRY_API_KEY_HERE"  // Obtain this from developer.aero
#define AppId   @"YOUR_APP_ID"     // Obtain this from developer.aero
#define EndPointURL  @"https://cube.api.aero"
#define Timeout 15

//Passenger Flight INFO
#define AirportCode @"YOUR_AIRPORT_CODE"  //IATA Three letter code like DFW or JFK
#define Flight   @"XS0001"
#define FlightDate   @"2015-06-29" //"YYYY-MM-dd"
#define PassengerName   @"Bilal Itani"


//FlIFO API INFO
#define FLIFOAPIKey @"YOUR_FLIFO_API_KEY_HERE" // Obtain this from developer.aero
#define FLIFOEndPointURL  @"https://flifo-qa.api.aero/flifo/v2/flights"
#define FLIFODetailsURL  @"https://flifo-qa.api.aero/flifo/v2/flight"
#define FLIFOAirportCode  @"MIA"
#define FLIFOAirlineCode  nil //If set to nil flight list will contain all flights for all airlines ar an set airport


