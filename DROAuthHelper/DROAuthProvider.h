//
//  DROAuthProvider.h
//  DROAuthHelper
//
//  Created by Dariusz Rybicki on 02.12.2013.
//  Copyright (c) 2013 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DROAuthHelper;

@protocol DROAuthProvider <NSObject>

@property (nonatomic, weak) DROAuthHelper *oauth;

/**
 Returns login url
 
 @return NSURL
 */
- (NSURL *)loginUrl;

/**
 Retruns YES if given URL is a (previously set) redirect url
 
 @param url
 @returns YES or NO
 */
- (BOOL)isRedirectURL:(NSURL *)url;

/**
 Requests access token basing on given redirect url
 
 @param url
 @param success block that will be called on success
 @param failure block that will be called on failure
 */
- (void)getAccessTokenFromRedirectURL:(NSURL *)url
							  success:(void (^)(NSString *accessToken))success
							  failure:(void (^)(NSError *error))failure;

@end
