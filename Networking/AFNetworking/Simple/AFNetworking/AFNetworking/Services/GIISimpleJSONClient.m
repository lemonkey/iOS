//
//  GIISimpleJSONClient.m
//  AFNetworking
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "GIISimpleJSONClient.h"

@implementation GIISimpleJSONClient

- (instancetype)initWithBaseURL:(NSURL *)url
{
	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

	sessionConfig.timeoutIntervalForRequest = 10.0f;
	sessionConfig.timeoutIntervalForResource = 10.0f;

	if(self = [super initWithBaseURL:url sessionConfiguration:sessionConfig])
	{
		self.requestSerializer = [AFJSONRequestSerializer serializer];
		self.responseSerializer = [AFJSONResponseSerializer serializer];
	}
	
	return self;
}

- (void)loadData
{
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	parameters[@"format"] = @"json";
	
	[self GET:@"/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
		if([self.delegate respondsToSelector:@selector(giiSimpleJSONClient:didUpdateWithData:)])
		{
			[self.delegate giiSimpleJSONClient:self didUpdateWithData:responseObject];
		}
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		if([self.delegate respondsToSelector:@selector(giiSimpleJSONClient:didFailWithError:)])
		{
			[self.delegate giiSimpleJSONClient:self didFailWithError:error];
		}
	}];
}

@end
