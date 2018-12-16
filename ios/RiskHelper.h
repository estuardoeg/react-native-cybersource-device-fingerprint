//
//  RiskHelper.h
//
//  Created by Estuardo Estrada on 12/16/18.
//  Copyright © 2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <TrustDefenderMobile/TrustDefenderMobile.h>


@interface RiskHelper : NSObject <TrustDefenderMobileDelegate, CLLocationManagerDelegate>

/**
 *  The designated initializer
 *
 *  @param config The WePay config
 *
 *  @return A \ref WPRiskHelper instance.
 */
- (instancetype) initWithLocation:(BOOL)useLocation;

/**
 *  Fetches a new session id. Triggers profiling if not already running.
 *  This method should be called everytime a sensitive API call is made.
 *
 *  @return The session id. Can be nil if profiling fails to start.
 */
- (NSString *) sessionId;

@end
