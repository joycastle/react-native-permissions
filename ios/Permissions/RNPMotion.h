//
//  RNPMotion.h
//  ReactNativePermissions
//
#import "RNPFeature.h"
#ifdef RNP_USE_MOTION

#import <Foundation/Foundation.h>
#import "RCTConvert+RNPStatus.h"

@interface RNPMotion : NSObject

+ (NSString *)getStatus;
+ (void)request:(void (^)(NSString *))completionHandler;

@end

#endif
