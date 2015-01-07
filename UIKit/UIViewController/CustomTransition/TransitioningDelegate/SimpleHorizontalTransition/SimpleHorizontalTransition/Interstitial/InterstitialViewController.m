//
//  InterstitialViewController.m
//  SimpleHorizontalTransition
//
//  Created by Ari Braginsky on 1/6/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "InterstitialViewController.h"

@implementation InterstitialViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	NSLog(@"interstitial viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	NSLog(@"interstitial viewDidAppear");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	NSLog(@"interstitial viewDidDisappear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	NSLog(@"interstitial viewWillDisappear");
}

- (IBAction)dismissButtonTapped:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:^{

		if(self.dismissBlock)
		{
			self.dismissBlock();
		}
	}];
}

@end
