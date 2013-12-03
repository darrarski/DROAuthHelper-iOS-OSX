//
//  DROAuthFacebook.h
//  DROAuthHelper
//
//  Created by Dariusz Rybicki on 02.12.2013.
//  Copyright (c) 2013 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DROAuthHelper.h"
#import "DROAuthProvider.h"

/// oAuth helper's Facebook provider error domain
extern NSString *const DROAuthFacebookErrorDomain;

/// Error code for error when code parameter not found in redirect url
extern NSInteger const DROAuthFacebookErrorCodeParameterNotFound;

/// Error code for error when invalid response recieved for access token request
extern NSInteger const DROAuthFacebookErrorInvalidResponseForAccesssToken;

/// Error code for error when access token not found in response
extern NSInteger const DROAuthFacebookErrorAccessTokenNotFoundInResponse;

@interface DROAuthFacebook : NSObject <DROAuthProvider>

/// oAuth helper object
@property (nonatomic, weak) DROAuthHelper *oauth;

/// Redirect URL string
@property (nonatomic, strong) NSString *redirectUrlString;

@end
