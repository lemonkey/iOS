//
//  GIIRESTClient+JSONDate.m
//  AFNetworking
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "GIIRESTClient+JSONDate.h"

NSString * const DateTimeURLString = @"http://date.jsontest.com";

@implementation GIIRESTClient (JSONDate)

+ (instancetype)jsonDateClient
{
	static GIIRESTClient *jsonDateClient = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		jsonDateClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:DateTimeURLString]];
	});
	
	return jsonDateClient;
}

@end
