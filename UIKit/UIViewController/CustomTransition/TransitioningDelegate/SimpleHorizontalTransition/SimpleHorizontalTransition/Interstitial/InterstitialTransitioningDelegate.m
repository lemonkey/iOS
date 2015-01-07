//
//  InterstitialTransitioningDelegate.m
//  SimpleHorizontalTransition
//
//  Created by Ari Braginsky on 1/6/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "InterstitialTransitioningDelegate.h"

@interface InterstitialTransitioningDelegate () <UIViewControllerAnimatedTransitioning>

@end

@implementation InterstitialTransitioningDelegate

+ (instancetype)sharedDelegate
{
	static InterstitialTransitioningDelegate *sharedDelegate = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedDelegate = [[self alloc] init];
	});
	
	return sharedDelegate;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
																  presentingController:(UIViewController *)presenting
																	  sourceController:(UIViewController *)source
{
	// note: self conforms to UIViewControllerAnimatedTransitioning protocol's required methods
	return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
	return self;
}

/*
 - (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
 presentingViewController:(UIViewController *)presenting
 sourceViewController:(UIViewController *)source {
	
	// new for iOS 8
 }
 */


#pragma mark - UIViewControllerAnimatedTransitioning

// UIViewControllerContextTransitioning
//
// A transition context object is constructed by the system and passed to the
// animator in its animateTransition: and transitionDuration: methods as well as
// to the interaction controller in its startInteractiveTransition: method. If
// there is an interaction controller its startInteractiveTransition: is called
// first and its up to the the interaction controller object to call the
// animateTransition: method if needed. If there is no interaction controller,
// then the system automatically invokes the animator's animateTransition:
// method.
//
// The system queries the view controller's transitionDelegate or the the
// navigation controller's delegate to determine if an animator or interaction
// controller should be used in a transition. The transitionDelegate is a new
// propery on UIViewController and conforms to the
// UIViewControllerTransitioningDelegate protocol defined below. The navigation
// controller likewise has been agumented with a couple of new delegate methods.
//
// The UIViewControllerContextTransitioning protocol can be adopted by custom
// container controllers.  It is purposely general to cover more complex
// transitions than the system currently supports. For now, navigation push/pops
// and UIViewController present/dismiss transitions can be
// customized. Information about the transition is obtained by using the
// viewControllerForKey:, initialFrameForViewController:, and
// finalFrameForViewController: methods. The system provides two keys for
// identifying the from view controller and the to view controller for
// navigation push/pop and view controller present/dismiss transitions.
//
// All custom animations must invoke the context's completeTransition: method
// when the transition completes.  Furthermore the animation should take place
// within the containerView specified by the context. For interactive
// transitions the context's updateInteractiveTransition:,
// finishInteractiveTransition or cancelInteractiveTransition should be called
// as the interactive animation proceeds. A concrete interaction controller
// class, UIPercentDrivenInteractiveTransition, is provided below to
// interactive; drive CA transitions defined by an animator.

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

	// the appropriate views are added to the current transitionContext containerView
	// depending on whether we're presenting or dismissing the modal view with the custom
	// presentation style

	UIView *fromView = fromVC.view;
	UIView *toView = toVC.view;
	
	CGRect endFrame = fromView.frame;
	
	BOOL presenting = toVC.isBeingPresented;

	if(presenting)
	{
		// interstitial is the "toView" where the main view is the "fromView"
		
		// prevent user from triggering any events on the current view as
		// the interstitial is presented over it
		fromView.userInteractionEnabled = NO;
		
		// add interstitial to context's containerView
		[transitionContext.containerView addSubview:toView];
		
		// set interstitial's start position off-screen to the right of main view
		CGRect startFrame = endFrame;
		startFrame.origin.x = startFrame.origin.x + toView.frame.size.width;
		toView.frame = startFrame;

		// begin animation:

		// Note (from UIViewController.h):
		// If a custom container controller manually forwards its appearance callbacks, then rather than calling
		// viewWillAppear:, viewDidAppear: viewWillDisappear:, or viewDidDisappear: on the children these methods
		// should be used instead. This will ensure that descendent child controllers appearance methods will be
		// invoked. It also enables more complex custom transitions to be implemented since the appearance callbacks are
		// now tied to the final matching invocation of endAppearanceTransition.
		//
		// Since -viewWillAppear is not called after dismissing a modal view that
		// has a custom transition, must call -beginAppearanceTransition and
		// -endAppearanceTransition on toVC.

		[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
			
			// final position of interstitial is at origin of main view
			toView.frame = endFrame;
			
			// main view will disappear
			[fromVC beginAppearanceTransition:NO animated:NO];
			
		} completion:^(BOOL finished) {
			
			// main view did disappear
			[fromVC endAppearanceTransition];

			[transitionContext completeTransition:YES];
		}];
	}
	else
	{
		// interstitial is now the "fromView" where the main view is the "toView"
		
		// allow user to interact with main view again
		toView.userInteractionEnabled = YES;

		// set end position of interstitial back to the right of main screen
		endFrame.origin.x += fromView.frame.size.width;

		// begin animation:
		[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
			
			// final position of interstitial is to the right of the main view
			fromView.frame = endFrame;
			
			// main view will appear
			[toVC beginAppearanceTransition:YES animated:NO];
			
		} completion:^(BOOL finished) {
			
			// main view did appear
			[toVC endAppearanceTransition];
			
			// remove interstitital from context's containerView
			[fromView removeFromSuperview];
			
			[transitionContext completeTransition:YES];
		}];
	}
}

@end
