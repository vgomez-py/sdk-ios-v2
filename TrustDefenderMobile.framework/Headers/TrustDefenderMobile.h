/*!
 @header TrustDefenderMobile.h

 TrustDefender Mobile SDK for iOS. This header is the main framework header, and is required to make use of the mobile SDK.

 @author Nick Blievers
 @copyright ThreatMetrix
*/
#ifndef _TRUSTDEFENDERMOBILE_H_
#define _TRUSTDEFENDERMOBILE_H_
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "THMStatusCode.h"

#ifdef __cplusplus
#define EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define EXTERN	    extern __attribute__((visibility ("default")))
#endif

/*
 * These macro's should not be used outside of special builds. They are here to allow
 * the easy generation of a build with all exported symbols mapped to particular prefix
 * to avoid clashing when SDKs include this library
 */
#define TDM_NAME_PASTE2( a, b) a##b
#define TDM_NAME_PASTE( a, b) TDM_NAME_PASTE2( a, b)

#ifndef TDM_PREFIX_NAME
#define NO_COMPAT_CLASS_NAME
#define TDM_PREFIX_NAME
#endif

/*
 * For this to work, all exported symbols must be included here
 */
#define TDMOrgID                        TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMOrgID)
#define TDMApiKey                       TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMApiKey)
#define TDMDelegate                     TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMDelegate)
#define TDMTimeout                      TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMTimeout)
#define TDMLocationServices             TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMLocationServices)
#define TDMLocationServicesWithPrompt   TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMLocationServicesWithPrompt)
#define TDMDesiredLocationAccuracy      TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMDesiredLocationAccuracy)
#define TDMKeychainAccessGroup          TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMKeychainAccessGroup)
#define TDMOptions                      TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMOptions)
#define TDMFingerprintServer            TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMFingerprintServer)
#define TDMProfileSourceURL             TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMProfileSourceURL)
#define TDMSessionID                    TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMSessionID)
#define TDMCustomAttributes             TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMCustomAttributes)
#define TDMLocation                     TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMLocation)
#define TDMProfileStatus                TDM_NAME_PASTE(TDM_PREFIX_NAME, TDMProfileStatus)

#ifndef TrustDefenderMobile
#define TrustDefenderMobile             TDM_NAME_PASTE(TDM_PREFIX_NAME, TrustDefenderMobile)
#endif


// Instance wide options
/*!
 @const TDMOrgID
 @abstract NSDictionary key for specifying the org id.
 @discussion Valid at init time to set the org id.

 This is mandatory.
 */
EXTERN NSString *const TDMOrgID;
/*!
 @const TDMApiKey
 @abstract NSDictionary key for specifying the API key, if one is required.
 @discussion Valid at init time to set the API key. Do not set unless instructed by
 Threatmetrix.
 */
EXTERN NSString *const TDMApiKey;
/*!
 @const TDMDelegate
 @abstract NSDictionary key for specifying the delegate.
 @discussion Valid at init time to set the delegate, which must comply to
 TrustDefenderMobileDelegate
 */
EXTERN NSString *const TDMDelegate;
/*!
 @const TDMTimeout
 @abstract NSDictionary key for specifying the network timeout.
 @discussion Valid at init time to set the network timeout, defaults to 10s

 Default is \@10 (note use of NSNumber to store int)
 */
EXTERN NSString *const TDMTimeout;
/*!
 @const TDMLocationServices
 @abstract NSDictionary key for enabling the location services.
 @discussion Valid at init time to enable location services. Note that
 this will never cause UI interaction -- if the application does not have
 permissions, no prompt will be made, and no location will be acquired.

 Default value is \@NO (note use of NSNumber to store BOOL)
 */
EXTERN NSString *const TDMLocationServices;
/*!
 @const TDMLocationServicesWithPrompt
 @abstract NSDictionary key for enabling the location services.
 @discussion Valid at init time to enable location services. Note that
 this can cause user interaction -- if the application does not have
 permissions, they will be prompted.

 Only one of TDMLocationServices or TDMLocationServicesWithPrompt should be set.

 Default value is \@NO (note use of NSNumber to store BOOL)
 */
EXTERN NSString *const TDMLocationServicesWithPrompt;

/*!
 @const TDMDesiredLocationAccuracy
 @abstract NSDictionary key for enabling the location services.
 @discussion Valid at init time and configures the desired location accuracy.

 Default value is \@1000.0 (note use of NSNumber to store float) which is
 equivilent to kCLLocationAccuracyKilometer
 */
EXTERN NSString *const TDMDesiredLocationAccuracy;

/*!
 @const TDMKeychainAccessGroup
 @abstract NSDictionary key for making use of the keychain access group.
 @discussion Valid at init time to enable the sharing of data across applications
 with the same keychain access group. This allows matching device ID across applications
 from the same vendor.
 */
EXTERN NSString *const TDMKeychainAccessGroup;

/*!
 @const TDMOptions
 @abstract NSDictionary key for setting specific options
 @discussion Valid at init time for fine grained control over profiling.

 Used internally. Do not set unless specified by ThreatMetrix.
 */
EXTERN NSString *const TDMOptions;
/*!
 @const TDMFingerprintServer
 @abstract NSDictionary key for setting a fingerprint server
 @discussion Valid at init time setting an alternative fingerprint server

 Defaults to \@"h-sdk.online-metrix.net"
 */
EXTERN NSString *const TDMFingerprintServer;
/*!
 @const TDMProfileSourceURL
 @abstract NSDictionary key for setting a custom url.
 @discussion Valid at init time for setting a custom referrer url
 */
EXTERN NSString *const TDMProfileSourceURL;

// Profile specific options.
/*!
 @const TDMSessionID
 @abstract NSDictionary key for Session ID.
 @discussion Valid at profile time, and result time for setting/retrieving the session ID.
 */
EXTERN NSString *const TDMSessionID;
/*!
 @const TDMCustomAttributes
 @abstract NSDictionary key for Custom Attributes.
 @discussion Valid at profile time for setting the any custom attributes to be included
 in the profiling data.
 */
EXTERN NSString *const TDMCustomAttributes;
/*!
 @const TDMLocation
 @abstract NSDictionary key for setting location.
 @discussion Valid at profile time for setting the location to be included
 in the profiling data.

 This should only be used if location services are not enabled.
 */
EXTERN NSString *const TDMLocation;

// Profile result options (TDMSessionID is shared)

/*!
 @const TDMProfileStatus
 @abstract NSDictionary key for retrieving the profiling status
 @discussion Valid at results time for getting the status of the current
 profiling request.
 */
EXTERN NSString *const TDMProfileStatus;


// NOTE: headerdoc2html gets confused if this __attribute__ is after the comment
__attribute__((visibility("default")))
/*!
 *    @interface TrustDefenderMobile
 *    @discussion TrustDefender Mobile SDK
 */
@interface TrustDefenderMobile : NSObject

- (id) init __attribute__((unavailable("Must use initWithConfig: instead.")));

/*!
 * Initialise the TrustDefenderMobile object with the supplied configuration dictionary.
 * @code
 * TrustDefenderMobile *tdSDK = [[TrustDefenderMobile alloc] initWithConfig:@{ TDMOrgID: @"my orgid" }];
 * @endcode
 */
-(id) initWithConfig:(NSDictionary *)config;

/*!
 *    Perform a profiling request.
 *
 *    @return THMStatusCode indicating whether the profiling request successfully launched
 */
-(THMStatusCode) doProfileRequest;

/*!
 *    Perform a profiling request.
 *
 *    @return THMStatusCode indicating whether the profiling request successfully launched
 */
-(THMStatusCode) doProfileRequest: (NSDictionary *)options;

/*!
 *     Perform a profiling request.
 *     callbackBlock is a block interface that is fired when the profiling request is completed.
 *     Note that if a block is passed in, the delegate callback will not be fired.
 */
-(THMStatusCode) doProfileRequestWithCallback: (void (^)(NSDictionary *))callbackBlock;

/*!
 *     Perform a profiling request.
 *     callbackBlock is a block interface that is fired when the profiling request is completed.
 *     Note that if a block is passed in, the delegate callback will not be fired.
 */
-(THMStatusCode) doProfileRequestWithOptions: (NSDictionary *)profileOptions andCallbackBlock: (void (^)(NSDictionary *))callbackBlock;

/*!
 *    Pause or resume location services
 *
 *    @param pause YES to pause, NO to unpause
 */
-(void) pauseLocationServices: (BOOL) pause;

/*!
 * Return the profiling result details
 */
-(NSDictionary *)getResult;

/*!
 *    Query the build number, for debugging purposes only
 */
-(NSString *)version;

/*!
 *    Cancel's the currently running sync request. If no request is outstanding, just returns
 */
-(void) cancel;

@end

/*!
 *    The delegate should implement this protocol to receive completion notification. Only one of the
 *    methods should be implemented.
 */
@protocol TrustDefenderMobileDelegate
/*!
 *    Once profiling is complete, this method is called.
 *
 *    @param profileResults describes the profiling status
 */
-(void) profileComplete: (NSDictionary *) profileResults;

@end
#endif
