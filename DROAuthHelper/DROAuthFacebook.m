//
//  DROAuthFacebook.m
//  DROAuthHelper
//
//  Created by Dariusz Rybicki on 02.12.2013.
//  Copyright (c) 2013 Darrarski. All rights reserved.
//

#import "DROAuthFacebook.h"
#import <DRURLParametersParser/DRURLParametersParser.h>
#import <AFNetworking/AFNetworking.h>

NSString *const DROAuthFacebookDefaultRedirectUrlString = @"https://www.facebook.com/connect/login_success.html";
NSString *const DROAuthFacebookLoginUrlString = @"https://www.facebook.com/dialog/oauth?client_id=%@&redirect_uri=%@";
NSString *const DROAuthFacebookAccessTokenUrlString = @"https://graph.facebook.com/oauth/access_token";
NSString *const DROauthFacebookClientIdParameterName = @"client_id";
NSString *const DROauthFacebookRedirectUrlParameterName = @"redirect_uri";
NSString *const DROauthFacebookClientSecretParameterName = @"client_secret";
NSString *const DROAuthFacebookCodeParameterName = @"code";
NSString *const DROAuthFacebookAccessTokenParameterName = @"access_token";

NSString *const DROAuthFacebookErrorDomain = @"DROAuthFacebook";
NSInteger const DROAuthFacebookErrorCodeParameterNotFoundInRedirectUrl = 1;
NSInteger const DROAuthFacebookErrorInvalidResponseForAccesssToken = 2;
NSInteger const DROAuthFacebookErrorAccessTokenNotFoundInResponse = 3;

@implementation DROAuthFacebook

- (NSString *)redirectUrlString
{
	if (!_redirectUrlString)
	{
		_redirectUrlString = DROAuthFacebookDefaultRedirectUrlString;
	}
	return _redirectUrlString;
}

- (NSURL *)loginUrl
{
	NSString *urlString = [NSString stringWithFormat:DROAuthFacebookLoginUrlString,
						   self.oauth.clientId,
						   self.redirectUrlString];
	
	return [NSURL URLWithString:urlString];
}

- (BOOL)isRedirectURL:(NSURL *)url
{
	NSString *urlString = [url absoluteString];
    return [urlString hasPrefix:self.redirectUrlString];
}

- (void)getAccessTokenFromRedirectURL:(NSURL *)url
							  success:(void (^)(NSString *accessToken))success
							  failure:(void (^)(NSError *error))failure
{
	DRURLParametersParser *parser = [[DRURLParametersParser alloc] initWithURL:url];
	NSString *code = [parser valueForParameter:DROAuthFacebookCodeParameterName];
	
	if (!(code && ![code isEqualToString:@""]))
	{
		if (failure)
		{
			NSError *error = [NSError errorWithDomain:DROAuthFacebookErrorDomain
												 code:DROAuthFacebookErrorCodeParameterNotFoundInRedirectUrl
											 userInfo:nil];
			failure(error);
		}
	}
	
	NSDictionary *parameters = @{ DROauthFacebookClientIdParameterName : self.oauth.clientId,
								  DROauthFacebookRedirectUrlParameterName : self.redirectUrlString,
								  DROauthFacebookClientSecretParameterName : self.oauth.clientSecret,
								  DROAuthFacebookCodeParameterName : code };
	
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	[manager GET:DROAuthFacebookAccessTokenUrlString
	  parameters:parameters
		 success:^(AFHTTPRequestOperation *operation, id responseObject)
	 {
		 NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
		 
		 if (!(responseString && ![responseString isEqualToString:@""]))
		 {
			 if (failure)
			 {
				 NSError *error = [NSError errorWithDomain:DROAuthFacebookErrorDomain
													  code:DROAuthFacebookErrorInvalidResponseForAccesssToken
												  userInfo:nil];
				 failure(error);
			 }
		 }
		 else
		 {
			 DRURLParametersParser *parser = [[DRURLParametersParser alloc] initWithParametersString:responseString];
			 NSString *accessToken = [parser valueForParameter:DROAuthFacebookAccessTokenParameterName];
			 
			 if (!(accessToken && ![accessToken isEqualToString:@""]))
			 {
				 if (failure)
				 {
					 NSError *error = [NSError errorWithDomain:DROAuthFacebookErrorDomain
														  code:DROAuthFacebookErrorAccessTokenNotFoundInResponse
													  userInfo:nil];
					 failure(error);
				 }
			 }
			 else
			 {
				 if (success)
				 {
					 success(accessToken);
				 }
			 }
		 }
	 }
		 failure:^(AFHTTPRequestOperation *operation, NSError *error)
	 {
		 if (failure)
		 {
			 failure(error);
		 }
	 }];
}

@end
