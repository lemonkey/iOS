//
//  GIISimpleJSONClient.h
//  AFNetworking
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"
#import "GIIBlocks.h"

@protocol GIISimpleJSONClientDelegate;

@interface GIISimpleJSONClient : AFHTTPSessionManager

@property (nonatomic, weak) id<GIISimpleJSONClientDelegate>delegate;

- (instancetype)initWithBaseURL:(NSURL *)url;

- (void)loadData;

@end


@protocol GIISimpleJSONClientDelegate <NSObject>

@optional
- (void)giiSimpleJSONClient:(GIISimpleJSONClient *)client didUpdateWithData:(id)data;
- (void)giiSimpleJSONClient:(GIISimpleJSONClient *)client didFailWithError:(NSError *)error;

@end