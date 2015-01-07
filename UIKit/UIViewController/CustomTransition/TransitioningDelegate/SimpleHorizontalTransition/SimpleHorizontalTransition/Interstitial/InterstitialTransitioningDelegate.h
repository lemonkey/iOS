//
//  InterstitialTransitioningDelegate.h
//  SimpleHorizontalTransition
//
//  Created by Ari Braginsky on 1/6/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InterstitialTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

+ (instancetype)sharedDelegate;

@end
