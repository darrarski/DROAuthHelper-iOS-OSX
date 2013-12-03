//
//  DROAuthHelper.m
//  DROAuthHelper
//
//  Created by Dariusz Rybicki on 02.12.2013.
//  Copyright (c) 2013 Darrarski. All rights reserved.
//

#import "DROAuthHelper.h"
#import <DRURLParametersParser/DRURLParametersParser.h>
#import <AFNetworking/AFNetworking.h>

@implementation DROAuthHelper

- (id)initWithProvider:(id<DROAuthProvider>)provider
			  clientId:(NSString *)clientId
		  clientSecret:(NSString *)clientSecret
{
	if (self = [super init])
	{
		_clientId = clientId;
		_clientSecret = clientSecret;
		provider.oauth = self;
		_provider = provider;
	}
	return self;
}

@end
