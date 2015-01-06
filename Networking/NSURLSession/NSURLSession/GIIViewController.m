//
//  GIIViewController.m
//  NSURLSession
//
//  Created by Ari Braginsky on 1/5/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

#import "GIIViewController.h"

static NSString * const DateTimeURLString = @"http://date.jsontest.com";
static NSString * const kDate = @"date";
static NSString * const kSeconds = @"milliseconds_since_epoch";
static NSString * const kTime = @"time";

typedef void (^CompletionBlock)(NSDictionary *, NSError *);

@interface GIIViewController ()

@property (weak, nonatomic) IBOutlet UIButton *getDateTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateValueLabel;

@property (strong, nonatomic) NSURLSession *urlSession;

@end

@implementation GIIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		NSURLSessionConfiguration *urlSessionDefaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
		urlSessionDefaultConfiguration.timeoutIntervalForRequest = 10.0;
		urlSessionDefaultConfiguration.HTTPAdditionalHeaders = @{@"Accept" : @"application/json"};

		_urlSession = [NSURLSession sessionWithConfiguration:urlSessionDefaultConfiguration
													delegate:nil
											   delegateQueue:nil];
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationItem.title = @"NSURLSession";
	
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	[self clearDisplay];
}

- (IBAction)infoButtonTapped:(id)sender
{
	self.getDateTimeButton.enabled = NO;

	[self clearDisplay];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

	[self fetchDateTime:^(NSDictionary *dto, NSError *error) {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
		self.getDateTimeButton.enabled = YES;

		if(error)
		{
		
			UIAlertController *responseErrorAlert = [UIAlertController alertControllerWithTitle:@"Error"
																						message:error.description
																				 preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
																   style:UIAlertActionStyleDefault
																 handler:nil];
			
			[responseErrorAlert addAction:cancelAction];
			
			[self presentViewController:responseErrorAlert animated:YES completion:nil];

			return;
		}
		
		if(dto)
		{
			self.timeValueLabel.text = dto[kDate];
			
			double seconds = [dto[kSeconds] doubleValue];
			self.secondsValueLabel.text = [NSString stringWithFormat:@"%.0f", seconds];
			
			self.dateValueLabel.text = dto[kTime];
		}
	}];
}

- (void)clearDisplay
{
	self.timeValueLabel.text = nil;
	self.secondsValueLabel.text = nil;
	self.dateValueLabel.text = nil;
}

- (void)fetchDateTime:(CompletionBlock)completionBlock
{
	NSURL *url = [NSURL URLWithString:DateTimeURLString];

	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request
													 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
														 
														 if(error)
														 {
															 if(completionBlock)
															 {
																 dispatch_async(dispatch_get_main_queue(), ^{
																	 completionBlock(nil, error);
																 });
															 }
															 
															 return;
														 }

														 NSError *jsonError;
														 NSDictionary *dateTimeObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
														 
														 if(!dateTimeObj)
														 {
															 if(completionBlock)
															 {
																 dispatch_async(dispatch_get_main_queue(), ^{
																	 completionBlock(nil, jsonError);
																 });
															 }

															 return;
														 }
														 
														 dispatch_async(dispatch_get_main_queue(), ^{
															 if(completionBlock)
															 {
																 completionBlock(dateTimeObj, nil);
															 }
														 });
													 }];
	
	[dataTask resume];
}

@end
