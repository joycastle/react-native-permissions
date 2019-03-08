//
//  ReactNativePermissions.m
//  ReactNativePermissions
//
//  Created by Yonah Forst on 18/02/16.
//  Copyright © 2016 Yonah Forst. All rights reserved.
//

@import Contacts;

#import "ReactNativePermissions.h"
#import "RNPFeature.h"

#if __has_include(<React/RCTBridge.h>)
  #import <React/RCTBridge.h>
#elif __has_include("React/RCTBridge.h")
  #import "React/RCTBridge.h"
#else
  #import "RCTBridge.h"
#endif

#if __has_include(<React/RCTConvert.h>)
  #import <React/RCTConvert.h>
#elif __has_include("React/RCTConvert.h")
  #import "React/RCTConvert.h"
#else
  #import "RCTConvert.h"
#endif

#if __has_include(<React/RCTEventDispatcher.h>)
  #import <React/RCTEventDispatcher.h>
#elif __has_include("React/RCTEventDispatcher.h")
  #import "React/RCTEventDispatcher.h"
#else
  #import "RCTEventDispatcher.h"
#endif

#ifdef RNP_USE_LOCATION
#import "RNPLocation.h"
#endif

#ifdef RNP_USE_CALENDAR
#import "RNPEvent.h"
#endif

#ifdef RNP_USE_BLUETOOTH
#import "RNPBluetooth.h"
#endif

#ifdef RNP_USE_AUDIOVIDEO
#import "RNPAudioVideo.h"
#endif

#ifdef RNP_USE_PHOTO
#import "RNPPhoto.h"
#endif

#ifdef RNP_USE_CONTACT
#import "RNPContacts.h"
#endif

#ifdef RNP_USE_SPEECH
#import "RNPSpeechRecognition.h"
#endif

#ifdef RNP_USE_MOTION
#import "RNPMotion.h"
#endif

#ifdef RNP_USE_MEDIALIBRARY
#import "RNPMediaLibrary.h"
#endif

#import "RNPNotification.h"
#import "RNPBackgroundRefresh.h"

@interface ReactNativePermissions()
#ifdef RNP_USE_LOCATION
@property (strong, nonatomic) RNPLocation *locationMgr;
#endif
#ifdef RNP_USE_BLUETOOTH
@property (strong, nonatomic) RNPBluetooth *bluetoothMgr;
#endif
@property (strong, nonatomic) RNPNotification *notificationMgr;
@end

@implementation ReactNativePermissions


RCT_EXPORT_MODULE();
@synthesize bridge = _bridge;

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init]) {
    }

    return self;
}

/**
 * run on the main queue.
 */
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}


RCT_REMAP_METHOD(canOpenSettings, canOpenSettings:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    resolve(@(UIApplicationOpenSettingsURLString != nil));
}


RCT_EXPORT_METHOD(openSettings:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    if (@(UIApplicationOpenSettingsURLString != nil)) {

        NSNotificationCenter * __weak center = [NSNotificationCenter defaultCenter];
        id __block token = [center addObserverForName:UIApplicationDidBecomeActiveNotification
                                               object:nil
                                                queue:nil
                                           usingBlock:^(NSNotification *note) {
                                               [center removeObserver:token];
                                               resolve(@YES);
                                           }];

        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


RCT_REMAP_METHOD(getPermissionStatus, getPermissionStatus:(RNPType)type json:(id)json resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *status;

    switch (type) {

#ifdef RNP_USE_LOCATION
        case RNPTypeLocation: {
            NSString *locationPermissionType = [RCTConvert NSString:json];
            status = [RNPLocation getStatusForType:locationPermissionType];
            break;
        }
#endif
#ifdef RNP_USE_AUDIOVIDEO
        case RNPTypeCamera:
            status = [RNPAudioVideo getStatus:@"video"];
            break;
        case RNPTypeMicrophone:
            status = [RNPAudioVideo getStatus:@"audio"];
            break;
#endif
#ifdef RNP_USE_PHOTO
        case RNPTypePhoto:
            status = [RNPPhoto getStatus];
            break;
#endif
#ifdef RNP_USE_CONTACT
        case RNPTypeContacts:
            status = [RNPContacts getStatus];
            break;
#endif
#ifdef RNP_USE_CALENDAR
        case RNPTypeEvent:
            status = [RNPEvent getStatus:@"event"];
            break;
        case RNPTypeReminder:
            status = [RNPEvent getStatus:@"reminder"];
            break;
#endif
#ifdef RNP_USE_BLUETOOTH
        case RNPTypeBluetooth:
            status = [RNPBluetooth getStatus];
            break;
#endif
        case RNPTypeNotification:
            status = [RNPNotification getStatus];
            break;
        case RNPTypeBackgroundRefresh:
            status = [RNPBackgroundRefresh getStatus];
            break;
#ifdef RNP_USE_SPEECH
        case RNPTypeSpeechRecognition:
            status = [RNPSpeechRecognition getStatus];
            break;
#endif
#ifdef RNP_USE_MEDIALIBRARY
        case RNPTypeMediaLibrary:
            status = [RNPMediaLibrary getStatus];
            break;
#endif
#ifdef RNP_USE_MOTION
        case RNPTypeMotion:
            status = [RNPMotion getStatus];
            break;
#endif
        default:
            status = RNPStatusUndetermined;
            break;
    }

    resolve(status);
}

RCT_REMAP_METHOD(requestPermission, permissionType:(RNPType)type json:(id)json resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *status;

    switch (type) {
#ifdef RNP_USE_LOCATION
        case RNPTypeLocation:
            return [self requestLocation:json resolve:resolve];
#endif
#ifdef RNP_USE_AUDIOVIDEO
        case RNPTypeCamera:
            return [RNPAudioVideo request:@"video" completionHandler:resolve];
        case RNPTypeMicrophone:
            return [RNPAudioVideo request:@"audio" completionHandler:resolve];
#endif
#ifdef RNP_USE_PHOTO
        case RNPTypePhoto:
            return [RNPPhoto request:resolve];
#endif
#ifdef RNP_USE_CONTACT
        case RNPTypeContacts:
            return [RNPContacts request:resolve];
#endif
#ifdef RNP_USE_CALENDAR
        case RNPTypeEvent:
            return [RNPEvent request:@"event" completionHandler:resolve];
        case RNPTypeReminder:
            return [RNPEvent request:@"reminder" completionHandler:resolve];
#endif
#ifdef RNP_USE_BLUETOOTH
        case RNPTypeBluetooth:
            return [self requestBluetooth:resolve];
#endif
        case RNPTypeNotification:
            return [self requestNotification:json resolve:resolve];
#ifdef RNP_USE_SPEECH
        case RNPTypeSpeechRecognition:
            return [RNPSpeechRecognition request:resolve];
#endif
#ifdef RNP_USE_MEDIALIBRARY
        case RNPTypeMediaLibrary:
            return [RNPMediaLibrary request:resolve];
#endif
#ifdef RNP_USE_MOTION
        case RNPTypeMotion:
            return [RNPMotion request:resolve];
#endif
        default:
            break;
    }
}

#ifdef RNP_USE_LOCATION
- (void) requestLocation:(id)json resolve:(RCTPromiseResolveBlock)resolve
{
    if (self.locationMgr == nil) {
        self.locationMgr = [[RNPLocation alloc] init];
    }

    NSString *type = [RCTConvert NSString:json];

    [self.locationMgr request:type completionHandler:resolve];
}
#endif

- (void) requestNotification:(id)json resolve:(RCTPromiseResolveBlock)resolve
{
    NSArray *typeStrings = [RCTConvert NSArray:json];

    UIUserNotificationType types;
    if ([typeStrings containsObject:@"alert"])
        types = types | UIUserNotificationTypeAlert;

    if ([typeStrings containsObject:@"badge"])
        types = types | UIUserNotificationTypeBadge;

    if ([typeStrings containsObject:@"sound"])
        types = types | UIUserNotificationTypeSound;


    if (self.notificationMgr == nil) {
        self.notificationMgr = [[RNPNotification alloc] init];
    }

    [self.notificationMgr request:types completionHandler:resolve];

}

#ifdef RNP_USE_BLUETOOTH
- (void) requestBluetooth:(RCTPromiseResolveBlock)resolve
{
    if (self.bluetoothMgr == nil) {
        self.bluetoothMgr = [[RNPBluetooth alloc] init];
    }

    [self.bluetoothMgr request:resolve];
}
#endif




@end
