//
//  DROAuthHelper.h
//  DROAuthHelper
//
//  Created by Dariusz Rybicki on 02.12.2013.
//  Copyright (c) 2013 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DROAuthProvider.h"

@interface DROAuthHelper : NSObject

/// provider object
@property (nonatomic, strong) id<DROAuthProvider> provider;

/// oAuth client id
@property (nonatomic, strong) NSString *clientId;

/// oAuth client secret
@property (nonatomic, strong) NSString *clientSecret;

/**
 Init helper with given provider
 
 @param clientId oAuth client id
 @param clientSecret oAuth client secret
 @return helper object
 */
- (id)initWithProvider:(id<DROAuthProvider>)provider
			  clientId:(NSString *)clientId
		  clientSecret:(NSString *)clientSecret;

@end
