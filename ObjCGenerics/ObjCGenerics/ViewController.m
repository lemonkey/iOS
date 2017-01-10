//
//  ViewController.m
//  ObjCGenerics
//
//  Created by Ari Braginsky on 9/27/16.
//  Copyright © 2016 MedHelp. All rights reserved.
//

@import CoreData;

#import "GenericManagedObject.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    GenericManagedObject<NSManagedObject *> *someManagedObject = [GenericManagedObject new];

    [self insertManagedObject:someManagedObject];
}

- (void)insertManagedObject:(id)object
{
    NSLog(@"object: %@", object);
}


@end
