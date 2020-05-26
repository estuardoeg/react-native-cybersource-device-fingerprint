//
//  RNCybersourceDeviceFingerprint.m
//
//  Created by Estuardo Estrada on 12/16/18.
//  Copyright © 2018. All rights reserved.
//

#import "RNCybersourceDeviceFingerprint.h"
#import <React/RCTLog.h>
#import <TMXProfiling/TMXProfiling.h>
#import <TMXProfilingConnections/TMXProfilingConnections.h>

static NSString *const kRejectCode = @"CyberSourceSDKModule";

@implementation RNCybersourceDeviceFingerprint{
    TMXProfiling *_defender;
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
    
    _defender = [TMXProfiling sharedInstance];
    
    @try {
        [_defender configure:@{
                               TMXOrgID: orgId,
                               // TMXFingerprintServer: serverURL,
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
    [_defender profileDeviceUsing:@{
       TMXCustomAttributes: attributes,
    } callbackBlock:^(NSDictionary * result) {
        TMXStatusCode statusCode = [[result valueForKey:TMXProfileStatus] integerValue];
        resolve(@{
                   @"sessionId": [result valueForKey:TMXSessionID],
                   @"status": @(statusCode),
                  });
    }];
}

@end
