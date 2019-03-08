//
//  RNPFeature.h
//  ReactNativePermissions
//
//  Created by Jian Wei on 2019/3/8.
//  Copyright © 2019年 Yonah Forst. All rights reserved.
//

#ifndef RNPFeature_h
#define RNPFeature_h

#if (defined(RNP_ALL) || defined(RNP_LOCATION)) && !defined(RNP_LOCATION_REMOVE)
#define RNP_USE_LOCATION
#endif

#if (defined(RNP_ALL) || defined(RNP_CALENDAR)) && !defined(RNP_CALENDAR_REMOVE)
#define RNP_USE_CALENDAR
#endif

#if (defined(RNP_ALL) || defined(RNP_BLUETOOTH)) && !defined(RNP_BLUETOOTH_REMOVE)
#define RNP_USE_BLUETOOTH
#endif

#if (defined(RNP_ALL) || defined(RNP_AUDIOVIDEO)) && !defined(RNP_AUDIOVIDEO_REMOVE)
#define RNP_USE_AUDIOVIDEO
#endif

#if (defined(RNP_ALL) || defined(RNP_PHOTO)) && !defined(RNP_PHOTO_REMOVE)
#define RNP_USE_PHOTO
#endif

#if (defined(RNP_ALL) || defined(RNP_CONTACT)) && !defined(RNP_CONTACT_REMOVE)
#define RNP_USE_CONTACT
#endif

#if (defined(RNP_ALL) || defined(RNP_SPEECH)) && !defined(RNP_SPEECH_REMOVE)
#define RNP_USE_SPEECH
#endif

#if (defined(RNP_ALL) || defined(RNP_MOTION)) && !defined(RNP_MOTION_REMOVE)
#define RNP_USE_MOTION
#endif

#if (defined(RNP_ALL) || defined(RNP_MEDIALIBRARY)) && !defined(RNP_MEDIALIBRARY_REMOVE)
#define RNP_USE_MEDIALIBRARY
#endif

#endif /* RNPFeature_h */
