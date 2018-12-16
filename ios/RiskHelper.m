//
//  RiskHelper.m
//
//  Created by Estuardo Estrada on 12/16/18.
//  Copyright © 2018. All rights reserved.
//

#import "RiskHelper.h"

@interface RiskHelper ()

@property (nonatomic, strong) TrustDefenderMobile* profile;
@property (nonatomic, strong) NSString* _sessionId;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL useLocation;

@end

@implementation RiskHelper

static NSInteger const PROFILING_TIMEOUT_SECS = 30;
static NSString * const ORG_ID = @"1snn5n9w";

- (instancetype) initWithLocation:(BOOL)useLocation
{
    if (self = [super init]) {
        // save location config
        self.useLocation = useLocation;
    }
    
    return self;
}

- (NSString *) sessionId
{
    if (!self._sessionId) {
        [self startProfiling];
    }
    
    return self._sessionId;
}

- (void) startProfiling
{
    // initialize a profileing scheme
    self.profile = [[TrustDefenderMobile alloc] init];
    
    // set location permission
    if (self.useLocation) {
        // ask user for permission - will only ask if the app has never asked before
        [self requestLocationPermission];
        
        // tell TM to use location
        [self.profile registerLocationServices];
        
        // set location accuracy
        self.profile.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    
    // set delegate
    self.profile.delegate = self;
    
    // set time out
    self.profile.timeout = PROFILING_TIMEOUT_SECS;
    
    // start profiling
//    thm_status_code_t status = [self.profile doProfileRequestFor:ORG_ID];
    
    thm_status_code_t status = [self.profile doProfileRequestFor:ORG_ID];
//                                                    connectingTo:@"h-sdk.online-metrix.net"];
    
    if (status == THM_OK) {
        // The profiling successfully started, store session id
        self._sessionId = self.profile.sessionID;
    } else {
        // handle error
        // nothing special
    }
}

- (void) requestLocationPermission
{
    // initialize a location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Check required for iOS 8.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // set location accuracy
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // request location updates
    [self.locationManager startUpdatingLocation];
    
    // stop asking for updates - TM will ask for location itself
    // [self.locationManager stopUpdatingLocation];
}


#pragma mark - TrustDefenderMobileDelegate methods

- (void) profileComplete:(thm_status_code_t) status;
{
    // If we registered a delegate, this function will be called once the profiling is complete
    if (status == THM_OK)
    {
        // No errors, profiling succeeded!
        // Do nothing special
    } else {
        // error!
        // Do nothing special
    }
    
    // stop requesting location
    [self.locationManager stopUpdatingLocation];
    
    // delete the sessionId
    self._sessionId = nil;
    
    // cleanup resources
    self.profile = nil;
}

#pragma mark - cleanup

- (void) dealloc
{
    // cancel profiling
    [self.profile cancel];
    
    // stop updating location if still active
    [self.locationManager stopUpdatingLocation];
    
    // nil out properties
    self.profile.delegate = nil;
    self.profile = nil;
    self._sessionId = nil;
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

@end

