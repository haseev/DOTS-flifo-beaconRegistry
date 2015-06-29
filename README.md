
Day of Travel Services - Flight Information
============

SITA DOTS FLIFO Beacon Registry SDK
============

This project comprises an SDK to call the REST APIs for the SITA Common use iBeacon Registry and the FLIFO API, and sample application showing how to use the SDK. The SDK provides a simple way to access the three main iBeacon registry APIs and the two FLIFO API.


SITA Common Use DOTS FLIFO Beacon Registry
============

This is an example XCode project and library that provides methods to call and interact with the SITA Flight Information API and the Beacon Registry.

The Beacon Registry is a registry of common use iBeacons for the Air Transport Industry (ATI).

The registry is a SITA initiative and provides the following services:

- It allows beacon owners (airlines, airports or 3rd parties) to manage their beacon infrastructure and track where they are placed in an airport.
- It enables airports to monitor beacon deployment to prevent radio interference with existing Wi-Fi access points
- It provides beacons owners with a simple mechanism to set the 'meta-data' associated with beacons.
- It provides an API for app developers who want to use these beacons for developing travel and other related apps.

The aims of the registry are to promote the use of beacons in the Air Transport Industry and reduce the cost and complexity of deployment. This can be achieved with the following design goals:

- Promote shared beacon infrastructure to reduce cost and complexity of deployment.
- Introduce standard beacon types and data definition to encourage reuse.
- Provide a simple to use API to discover beacons and get meta-data about beacons.
- Provide tools to airport operators and beacon owners to visualize and track beacons.
- Be vendor agnostic - the service should work with beacons from any vendor.

Please visit [developer.aero](http://www.developer.aero) for more information on the Beacon Registry.


The SITA Flight Information API (FliFo) provides information and status for flights from airports around the world.

The All Flights api returns the current status of all flights at that airport, for that airline, for either arrivals or departures. The response is in the format of an array of flight records.

The Flight Record API returns the current status of the flight. 


Please visit [developer.aero](http://www.developer.aero) for more information on the FLIFO API.


What the sample app does
============

The app is a simple use case showing how to use the three key APIs from the SITA iBeacon Common Use Registry and two key APIs from the FLIFO API. 

- Get list of beacons at a given airport
- Get details about a specific beacon at a given airport
- Post a beacon detection report to be used for health monitoring of beacons at the registry.
- Get all flights at that airport, for that airline, for either arrivals or departures.
- Get a selected Flight Record.

Additionally, the methods above are complimented with some code to:

- Range for beacons based upon unique UUIDs returned from the registry.
- Store beacon detection logs in application local storage until they are posted to the registry.
- Trigger method to post the beacon detection report.
- Get and display the list of arrivals, departures, and a selected flight

How to build the sample app
============

- Download this package and launch the project in Xcode.  
- Add your API Key and AppID to the constants.h (get your API keys from  [developer.aero](http://www.developer.aero))
- Fix the provisioning and code signing files.
- Turn Bluetooth ON on your device.
- Build the project to your iOS device.

When the application launches and you tap on the Get Beacons button, the app will retrieve a list of beacons for the airport defined in constants.h. The app will then:

- Range for beacons in the proximity of your device.
- Show beacons that match the registry and others that may not already be included.  All beacons that show up when the app ranges will be saved to the beacon detection logs.
- Show temporary beacon detection report by tapping on the View Activity button. 
- Post the beacon detection report to the registry when the Provide Feedback button is tapped.


When the application launches and you tap on the Get Arrivals button, the app will retrieve a list of flights for the airport and/or airline defined in constants.h. The app will then:

- Navigate to a list of flights grouped by airline, clicking the airline will list all flights, selecting a flight will get the flight record.

How can I use this code in my project?
============

The methods for using the Beacon Registry are included in the /SITA_DOTS_SDK folder of the project:

- Include the /SITA_DOTS_SDK folder in your project. (SITA_DOTS_SDK.h & libSITA_DOTS_SDK.a)
- Link the library (libBeaconRegistrySDK.a) in your project:
![alt tag](https://github.com/sitalab/DOTS-flifo-beaconRegistry/blob/master/SITA_DOTS_SDK.png)

The library has multiple methods you can use all included in SITA_DOTS_SDK.h:

App Specific Methods (Init & Logging)
------

```- (BeaconRegistrySDK*)initializeWithAPIParams:(NSString *)APIkey : (NSString *)AppID : (NSString *)EndPoint : (int)TimeOut;```

 This is the initialization method that will create an instance of the BeaconRegistrySDK and initializes it with API info: APIkey, flightNumber, AppID, service endpoint, and timeout.

```- (void)beaconDetectionLog:(NSArray *)beaconsArray;```

This method accepts an Array of beacon objects (CLBeacon) and locally stores a log for every beacon, later these logs can be posted to API via the beaconDetectionReport method.

REST API Methods
------

```- (void)setFlightInfo: (NSString *)airportCode : (NSString *)flightNumber : (NSString *)flightDate : (NSString *)paxName;```

This is an optional method that sets the BeaconRegistrySDK flight info: airportCode, flightNumber, flightDate, and flightDate.  This method must be called prior to invoking getBeacons:, getBeaconDetails:, addBeaconsLog:, and postBeaconsLogToServer.

```- (void)getBeacons:(NSString *)airportCode :(void (^) (NSDictionary *response))handler;```

This method gets a list of beacons at a given airport code, it accepts airport code as input and returns a NSDictionary of beacons, response can be retrieved from the completion handler of this method, if airportCode is nil then the airportcode set in method setFlightInfo: will be used.

```- (void)getBeaconDetails:(NSString *)UUID : (NSString *)major : (NSString *)minor : (int)rssi :(void (^) (NSDictionary *response))handler;```

This method gets the details of a beacon from registry, it accepts beacon's UUID, major, minor, and rssi code as inputs and returns a NSDictionary of beacon details, response can be retrieved from the completion handler of this method.

```- (void) beaconDetectionReport:(void (^) (int response))handler;```

This method will post the locally stored beacons logs to API, on success response value will be "200", response can be retrieved from the completion handler of this method.



```- (void)setFlifoApiInfo: (NSString *)FLIFOEndPointURL : (NSString *)FLIFODetailsURL : (NSString *)FLIFOAPIKey;```

This is the initialization method that will initialize the SDK with required FLIFO API info.


```- (void)getFlights: (NSString *)FLIFOAirportCode : (NSString *)FLIFOAirlineCode :(NSString *)adi :(void (^) (NSDictionary *response))handler;```

This method gets the list of flights at a given airport, flights can be retrieved by either by airport code or by airport code and airline code, in case no airline code is specified, the flight list will contain all flights at the selected airport, method accepts FLIFOAirportCode, FLIFOAirlineCode, arrival/departure flag and returns a NSDictionary of flight list, response can be retrieved from the completion handler of this method.

```- (void)getFlightDetails: (NSString *)FLIFOAirportCode : (NSString *)FLIFOAirlineCode : (NSString *)flightNumber :(NSString *)adi :(void (^) (NSDictionary *response))handler;```

This method gets the details of a single flight, method accepts FLIFOAirportCode, FLIFOAirlineCode, flightNumber, arrival/departure flag and returns a NSDictionary of flight details, response can be retrieved from the completion handler of this method.


FAQs
===
*Can I get access to the iBeacons deployed at airports?*

Currently access is still limited to airlines, airports and ground handlers. The plan is to open access to general 3rd parties in the future. 


Contributors
============
* [bilalitani](https://github.com/bilalitani) / Bilal Itani
* [kosullivansita](https://github.com/kosullivansita) / [Kevin O'Sullivan](http://www.sita.aero/surveys-reports/sita-lab)

License
=======

This project is licensed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.html).



1800 = 07 08
16 = 108
Period: 3 digit hexa
Modes: 12



11F8D010-991F-4FDD-868C-CDD6EE671BC4


A6702217-BDC4-45F4-8198-9B7A6E979AB3





iOS Project Startup

Check out the iOS iTravel 1 project from: https://xp-dev.com/svn/iTraveliPhone
Create a new iOS 8 project with tabbed navigation, core data enabled, and add the items: “Trips / Check in”, “Book A Flight”, “Check Flight Status”, “Deals And Offers”, “More"

In the old project there are different targets with different splash screens and icons located in “Resources/zz” “Resources/mh”, create the required iOS 8 splash images and icons from them. Required icons/splash sizes are here: https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/IconMatrix.html#//apple_ref/doc/uid/TP40006556-CH27-SW1 

The “More” tab should present a modal view with more options to select from, “Schedule”, “Track My Bags”, “Airline Sales Office”, “Call Centers”, “Legal Terms”, “Terms & Conditions”, “Privacy Policy”, “Quick Tips”, “About This App”

Use the same Constants.h file for now.

Pull the config API logic from old repository and integrate in new project, we’ll have to use NSURLSessions instead of ASIHTTPRequest.

Create the required schema to store the config API response, at application start we should call the config API with config last update value stored and only if there is a response we should replace the old response with new one.

New project should be committed to https://xp-dev.com/svn/iTravelios8




