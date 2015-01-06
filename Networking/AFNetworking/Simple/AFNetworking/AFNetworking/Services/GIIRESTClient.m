//
//  GIIRESTClient.m
//  AFNetworking
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "GIIRESTClient.h"

@implementation GIIRESTClient

- (instancetype)initWithBaseURL:(NSURL *)url
{
	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

	sessionConfig.timeoutIntervalForRequest = 10.0f;
	sessionConfig.timeoutIntervalForResource = 10.0f;

	if(self = [super initWithBaseURL:url sessionConfiguration:sessionConfig])
	{
		// Can also subclass AFURLRequestSerializer
		self.requestSerializer = [AFHTTPRequestSerializer serializer];
		[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		[self.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
		
		// Can also subclass AFURLResponseSerializer (custom parsing of response for error handling, etc.)
		self.responseSerializer = [AFJSONResponseSerializer serializer];
		self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
		
		// Main queue (serial) is used by default if we don't specify.
		// Global queue (concurrent) with default priority normally good enough.
		self.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	}

	return self;
}

- (BOOL)gii_cancelURLSessionTaskWithMethod:(NSString *)method path:(NSString *)path
{
	__block BOOL didCancel = NO;

	[self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
		
		for(NSURLSessionDataTask *dataTask in dataTasks)
		{
			didCancel = [self cancelURLSessionTask:dataTask withMethod:method path:path];
		}
		
		for(NSURLSessionDownloadTask *downloadTask in downloadTasks)
		{
			didCancel = [self cancelURLSessionTask:downloadTask withMethod:method path:path];
		}
		
		for(NSURLSessionUploadTask *uploadTask in uploadTasks)
		{
			didCancel = [self cancelURLSessionTask:uploadTask withMethod:method path:path];
		}
	}];
	
	return didCancel;
}

- (BOOL)cancelURLSessionTask:(NSURLSessionTask *)task withMethod:(NSString *)method path:(NSString *)path {
	
	if(!task || method.length == 0 || path.length == 0)
	{
		return NO;
	}
	
//	NSLog(@"method: %@, path: %@", [task.originalRequest HTTPMethod], [[task.originalRequest URL] path]);
	
	BOOL methodIsEqual = !method || [method isEqualToString:[task.originalRequest HTTPMethod]];
	BOOL pathIsEqual = [[[task.originalRequest URL] path] isEqual:path];
	
	if(methodIsEqual && pathIsEqual)
	{
		[task cancel];
		
		return YES;
	}

	return NO;
}

@end
