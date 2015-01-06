//
//  GIIRESTClient+JSONDate.h
//  AFNetworking
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "GIIRESTClient.h"

extern NSString * const DateTimeURLString;

@interface GIIRESTClient (JSONDate)

+ (instancetype)jsonDateClient;

@end
