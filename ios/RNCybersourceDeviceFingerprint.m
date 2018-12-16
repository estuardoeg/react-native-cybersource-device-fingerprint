//
//  RNCybersourceDeviceFingerprint.m
//
//  Created by Estuardo Estrada on 12/16/18.
//  Copyright © 2018. All rights reserved.
//

#import "RNCybersourceDeviceFingerprint.h"
#import <React/RCTLog.h>

@implementation RNCybersourceDeviceFingerprint

- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(getSessionID:(RCTResponseSenderBlock)callback){
    callback(@[ [self getSessionId] ]);
}

- (NSString *) getSessionId{
    if (!self.riskHelper) {
        self.riskHelper = [[RiskHelper alloc] initWithLocation:YES];
    }
    return [self.riskHelper sessionId];
}

@end
