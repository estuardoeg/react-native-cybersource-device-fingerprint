//
//  RNCybersourceDeviceFingerprint.m
//
//  Created by Estuardo Estrada on 12/16/18.
//  Copyright © 2018. All rights reserved.
//

#import "RNCybersourceDeviceFingerprint.h"
#import <React/RCTLog.h>
#import <TrustDefender/TrustDefender.h>

static NSString *const kRejectCode = @"CyberSourceSDKModule";

@implementation RNCybersourceDeviceFingerprint{
    THMTrustDefender *_defender;
}

- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(
                  configure:(NSString *)orgId
                  // serverURL:(NSString *)serverURL
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  ) {
    if (_defender) {
        reject(kRejectCode, @"CyberSource SDK is already initialised", nil);
        return;
    }
    
    _defender = [THMTrustDefender sharedInstance];
    
    @try {
        [_defender configure:@{
                               THMOrgID: orgId,
                               // THMFingerprintServer: serverURL,
                               }];
    } @catch (NSException *exception) {
        reject(kRejectCode, @"Invalid parameters", nil);
        return;
    }
    
    resolve(@YES);
}

RCT_EXPORT_METHOD(
                  getSessionID:(NSArray *)attributes
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  ) {
    [_defender doProfileRequestWithOptions:@{
                                             THMCustomAttributes: attributes,
                                             } andCallbackBlock:^(NSDictionary *result) {
                                                 THMStatusCode statusCode = [[result valueForKey:THMProfileStatus] integerValue];
                                                 resolve(@{
                                                           @"sessionId": [result valueForKey:THMSessionID],
                                                           @"status": @(statusCode),
                                                           });
                                             }];
}

@end
