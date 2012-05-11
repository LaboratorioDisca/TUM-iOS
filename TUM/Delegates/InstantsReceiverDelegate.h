//
//  InstantsReceiverDelegate.h
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InstantsReceiverDelegate <NSObject>

@required
- (void) vehicleInstantsLoad:(NSArray*)instants;

@end
