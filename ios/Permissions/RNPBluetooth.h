//
//  RNPBluetooth.h
//  ReactNativePermissions
//
//  Created by Yonah Forst on 11/07/16.
//  Copyright © 2016 Yonah Forst. All rights reserved.
//
#import "RNPFeature.h"
#ifdef RNP_USE_BLUETOOTH

#import <Foundation/Foundation.h>
#import "RCTConvert+RNPStatus.h"

@interface RNPBluetooth : NSObject

+ (NSString *)getStatus;
- (void)request:(void (^)(NSString *))completionHandler;

@end

#endif
