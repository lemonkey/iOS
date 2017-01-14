//
//  ViewController.h
//  ParallelTest
//
//  Created by Ari Braginsky on 1/9/17.
//  Copyright © 2017 Ari Braginsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

+ (void)loadRemoteSVG:(BOOL)threadSafe forURLString:(NSString *)url;

@end

