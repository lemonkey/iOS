//
//  ViewController.m
//  SimpleHorizontalTransition
//
//  Created by Ari Braginsky on 1/6/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "ViewController.h"
#import "InterstitialViewController.h"
#import "InterstitialTransitioningDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationItem.title = @"Horizontal Transition";
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	NSLog(@"main viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	NSLog(@"main viewDidAppear");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	NSLog(@"main viewDidDisappear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	NSLog(@"main viewWillDisappear");
}

- (IBAction)buttonTapped:(id)sender
{
	InterstitialViewController *interstitial = [[InterstitialViewController alloc] init];
	interstitial.modalPresentationStyle = UIModalPresentationCustom;
	interstitial.transitioningDelegate = [InterstitialTransitioningDelegate sharedDelegate];
	interstitial.dismissBlock = ^{
		NSLog(@"interstitial dismissed!");
	};
	
	// This method sets the presentedViewController property to the specified
	// view controller (interstitial), resizes that view controller's view based
	// on the presentation style (custom -- see transitioningDelegate) and then
	// adds the view to the view hierarchy. The view is animated onscreen according
	// to the transition style (custom -- see transitionDelegate) specified in
	// the modalTransitionStyle property of the presented view controller.
	[self presentViewController:interstitial animated:YES completion:^{
		NSLog(@"interstitial presented!");
	}];
}

@end
