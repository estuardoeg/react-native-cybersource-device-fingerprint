//
//  RNCybersourceDeviceFingerprint.h
//
//  Created by Estuardo Estrada on 12/16/18.
//  Copyright © 2018. All rights reserved.
//

#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
#import "RiskHelper.h"

@interface RNCybersourceDeviceFingerprint : NSObject <RCTBridgeModule>

@property(nonatomic, strong) RiskHelper *riskHelper;
- (NSString *) getSessionId;

@end
