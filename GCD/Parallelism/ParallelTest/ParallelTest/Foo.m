//
//  Foo.m
//  ParallelTest
//
//  Created by Ari Braginsky on 1/9/17.
//  Copyright © 2017 Ari Braginsky. All rights reserved.
//

#import "Foo.h"

static NSString *theString;

static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation Foo

- (id)init
{
    if(self = [super init])
    {
        [self updateString];
    }
    
    return self;
}

- (void)checkString
{
//    return theString;
    NSLog(@"Current value of theString: %@", theString);
}

- (void)updateString
{
    theString = [NSString stringWithFormat:@"string:%c", [letters characterAtIndex:(rand() % [letters length])]];
}

@end
