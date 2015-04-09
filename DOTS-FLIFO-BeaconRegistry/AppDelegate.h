//
//  AppDelegate.h
//  DOTS-FLIFO-BeaconRegistry
//
//  Created by Apple on 10/31/14.
//  Copyright (c) 2014 SITA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITA_DOTS_SDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) SITA_DOTS_SDK *SITA_DOTS_SDKObject;

+ (AppDelegate *)sharedAppDelegate;

@end
