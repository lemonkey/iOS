//
//  InterstitialViewController.h
//  SimpleHorizontalTransition
//
//  Created by Ari Braginsky on 1/6/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterstitialViewController : UIViewController

@property (nonatomic, copy) void (^dismissBlock)(void);

@end
