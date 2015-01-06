//
//  GIIRESTClient.h
//  AFNetworking
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface GIIRESTClient : AFHTTPSessionManager

- (BOOL)gii_cancelURLSessionTaskWithMethod:(NSString *)method path:(NSString *)path;

@end
