//
//  ViewController.m
//  ParallelTest
//
//  Created by Ari Braginsky on 1/9/17.
//  Copyright © 2017 Ari Braginsky. All rights reserved.
//

#define dispatch_async_main(...) dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ });
#define dispatch_async_bg(...) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ __VA_ARGS__ })

#import "Foo.h"

@import SVGKit_MH;

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_DEFAULT, 0);
    dispatch_queue_t customQueue = dispatch_queue_create("testQueue", attr);

    dispatch_queue_t defaultBackgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // You can specify either a serial queue or a concurrent queue when calling dispatch_apply or dispatch_apply_f. Passing in a concurrent queue allows you to perform multiple loop iterations simultaneously and is the most common way to use these functions. Although using a serial queue is permissible and does the right thing for your code, using such a queue has no real performance advantages over leaving the loop in place.

    NSArray *svgImageURLs = @[ @"https://www.dropbox.com/s/v1m7mytwt381bet/trends.svg?raw=1", @"https://www.dropbox.com/s/hd8kdjft5c8s5vt/more_icon.svg?raw=1", @"https://www.dropbox.com/s/4zk5b04wecb8sde/to_do.svg?raw=1", @"https://www.dropbox.com/s/lbm6uedkywz2y3k/communities.svg?raw=1"];

    NSLog(@">>> Starting for loop");

    for(NSUInteger i = 0; i < svgImageURLs.count; i++)
    {
        dispatch_async_bg({

            NSLog(@"Thread: %@, Iteration: %zu", [NSThread currentThread], i);

//            [self loadRemoteSVG:NO];

            [ViewController loadRemoteSVG:NO forURLString:[svgImageURLs objectAtIndex:i]];

        });
    }

    [NSThread sleepForTimeInterval:2];
//
//    NSLog(@">>> Starting for loop");
//
//    for(NSUInteger i = 0; i < 10; i++)
//    {
//        dispatch_async_bg({
//
//            NSLog(@"Thread: %@, Iteration: %zu", [NSThread currentThread], i);
//
//            [self loadRemoteSVG:NO];
//            
//        });
//    }

    NSLog(@">>> Starting dispatch_apply");

    dispatch_apply(svgImageURLs.count, defaultBackgroundQueue, ^(size_t i) {

        NSLog(@"Thread: %@, Iteration: %zu", [NSThread currentThread], i);

        [ViewController loadRemoteSVG:NO forURLString:[svgImageURLs objectAtIndex:i]];
    });
}

- (void)loadLocalSVG
{
    // ???
}

- (void)loadRemoteSVG:(BOOL)threadSafe
{
    [ViewController loadRemoteSVG:threadSafe forURLString:@"https://www.dropbox.com/s/4zk5b04wecb8sde/to_do.svg?raw=1"];
}

+ (void)loadRemoteSVG:(BOOL)threadSafe forURLString:(NSString *)url
{
    NSParameterAssert(url);

    NSLog(@"url: %@", url);

    NSURL *theURL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:theURL
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:60];
    NSError *error;
    NSURLResponse *response;

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    if(!data)
    {
        return;
    }

    SVGKImage *svgImage = nil;

    if (data.length)
    {
        if(!threadSafe)
        {
            // NOT THREAD SAFE
            svgImage = [[SVGKImage alloc] initWithData:data];
        }
        else
        {
            // THREAD SAFE
            svgImage = [SVGKImage imageWithData:data];
        }

        NSLog(@"DONE: [%@]", svgImage);

        dispatch_async_main({
            NSLog(@"new image: %@", svgImage.UIImage);
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
