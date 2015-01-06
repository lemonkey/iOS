//
//  ViewController.m
//  AFNetworking
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "GIIBlocks.h"
#import "GIIViewController.h"
#import "GIISimpleJSONClient.h"
#import "GIIRESTClient+JSONDate.h"

static NSString * const kDate = @"date";
static NSString * const kSeconds = @"milliseconds_since_epoch";
static NSString * const kTime = @"time";

@interface GIIViewController () <GIISimpleJSONClientDelegate>

@property (nonatomic, weak) IBOutlet UIButton *getDateTimeButton;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *secondsLabel;
@property (nonatomic, weak) IBOutlet UILabel *secondsValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateValueLabel;

@property (nonatomic, strong) GIISimpleJSONClient *simpleJSONClient;
@property (nonatomic, strong) GIIRESTClient *jsonDateRESTClient;

@end

@implementation GIIViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{

		self.simpleJSONClient = [[GIISimpleJSONClient alloc] initWithBaseURL:[NSURL URLWithString:DateTimeURLString]];
		self.simpleJSONClient.delegate = self;
		
		self.jsonDateRESTClient = [GIIRESTClient jsonDateClient];
		
	});
	
	self.navigationItem.title = @"AFNetworking (Simple)";
	
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	[self clearDisplay];
}

- (void)clearDisplay
{
	self.timeValueLabel.text = nil;
	self.secondsValueLabel.text = nil;
	self.dateValueLabel.text = nil;
}

- (IBAction)infoButtonTapped:(id)sender
{
	// comment out to test cancellation of fetchWithSessionManagerSubclass request
//	self.getDateTimeButton.enabled = NO;
	
	[self clearDisplay];
	
	GIICompletionBlock completionBlock = ^(NSDictionary *dto, NSError *error) {
		
		// comment out to test cancellation of fetchWithSessionManagerSubclass request
//		self.getDateTimeButton.enabled = YES;
		
		if(error)
		{
			[self showAlertForError:error];
			return;
		}
		
		if(dto)
		{
			[self updateDisplayWithDto:dto];
		}
	};

	[self fetchWithCompletionBlock:completionBlock];
}

- (void)showAlertForError:(NSError *)error
{
	if(!error)
	{
		return;
	}
	
	UIAlertController *responseErrorAlert = [UIAlertController alertControllerWithTitle:@"Error"
																				message:error.description
																		 preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
														   style:UIAlertActionStyleDefault
														 handler:nil];
	
	[responseErrorAlert addAction:cancelAction];
	
	[self presentViewController:responseErrorAlert animated:YES completion:nil];
}

- (void)updateDisplayWithDto:(NSDictionary *)dto
{
	if(!dto)
	{
		return;
	}
	
	self.timeValueLabel.text = dto[kDate];
	
	double seconds = [dto[kSeconds] doubleValue];
	self.secondsValueLabel.text = [NSString stringWithFormat:@"%.0f", seconds];
	
	self.dateValueLabel.text = dto[kTime];
}

- (void)fetchWithCompletionBlock:(GIICompletionBlock)block
{
	if(block)
	{
		// 1. Local AFHTTPSessionManager example
		//[self fetchWithLocalSessionManager:block];
		
		// 2. Subclassing AFHTTPSessionManager using delegate
		//[self fetchWithSessionManagerSubclassDelegate];
		
		// 3. Subclassing AFHTTPSessionManager using success/failure blocks directly
		[self fetchWithSessionManagerSubclass:block];
	}
}

#pragma mark - 1. Local AFHTTPSessionManager example

- (void)fetchWithLocalSessionManager:(GIICompletionBlock)block
{
	NSURL *baseURL = [NSURL URLWithString:DateTimeURLString];
	NSDictionary *parameters = @{@"format": @"json"};
	
	NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

	sessionConfig.timeoutIntervalForRequest = 10.0f;
	sessionConfig.timeoutIntervalForResource = 10.0f;

	sessionConfig.HTTPAdditionalHeaders = @{@"Accept" : @"application/json"};
	
	AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:sessionConfig];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	
	[manager GET:@"/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {

		if(block)
		{
			dispatch_async(dispatch_get_main_queue(), ^{
				block(responseObject, nil);
			});
		}
		
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		
		if(block)
		{
			dispatch_async(dispatch_get_main_queue(), ^{
				block(nil, error);
			});
		}
		
	}];
}

#pragma mark - 2. Subclassing AFHTTPSessionManager using delegate

- (void)fetchWithSessionManagerSubclassDelegate
{
	[self.simpleJSONClient loadData];
}

- (void)giiSimpleJSONClient:(GIISimpleJSONClient *)client didUpdateWithData:(id)data
{
	self.getDateTimeButton.enabled = YES;

	if(data)
	{
		[self updateDisplayWithDto:data];
	}
}

- (void)giiSimpleJSONClient:(GIISimpleJSONClient *)client didFailWithError:(NSError *)error
{
	self.getDateTimeButton.enabled = YES;

	if(error)
	{
		[self showAlertForError:error];
	}
}

#pragma mark - 3. Subclassing AFHTTPSessionManager using success/failure blocks directly

- (void)fetchWithSessionManagerSubclass:(GIICompletionBlock)block
{
	// cancel any pending jsonDateRESTClient request
	[self.jsonDateRESTClient gii_cancelURLSessionTaskWithMethod:@"GET" path:@"/"];
	
	[self.jsonDateRESTClient GET:@"/" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		
		if(block)
		{
			// original request was dispatched on a default global concurrent queue
			dispatch_async(dispatch_get_main_queue(), ^{
				block(responseObject, nil);
			});
		}
		
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		
		// task cancellation have an error code NSURLErrorCancelled
		if(error.code == NSURLErrorCancelled)
		{
			NSLog(@"previous jsonDateClient request cancelled!");
			return;
		}
		
		if(block)
		{
			dispatch_async(dispatch_get_main_queue(), ^{
				block(nil, error);
			});
		}
		
	}];
}

@end
