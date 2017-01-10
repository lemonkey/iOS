//
//  GenericManagedObject.h
//  ObjCGenerics
//
//  Created by Ari Braginsky on 9/27/16.
//  Copyright © 2016 MedHelp. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface GenericManagedObject<__covariant T:NSManagedObject *> : NSObject

//- (void)doSomethingWithGeneric:(T)object;

@end
