//
//  NSObject_BlockAdditions.h
//  TUM
//
//  Created by Alejandro on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSThread (Blocks)

+ (void)MCSM_performBlockOnMainThread:(void (^)())block{
	[[NSThread mainThread] MCSM_performBlock:block];
}

+ (void)MCSM_performBlockInBackground:(void (^)())block{
	[NSThread performSelectorInBackground:@selector(MCSM_runBlock:)
                               withObject:[block copy]];
}

+ (void)MCSM_runBlock:(void (^)())block{
	block();
}


- (void)MCSM_performBlock:(void (^)())block{
    
	if ([[NSThread currentThread] isEqual:self])
        block();
	else
        [self MCSM_performBlock:block waitUntilDone:NO];
}
- (void)MCSM_performBlock:(void (^)())block waitUntilDone:(BOOL)wait{
    
	[NSThread performSelector:@selector(MCSM_runBlock:)
					 onThread:self
				   withObject:[block copy]
				waitUntilDone:wait];
}

- (void)MCSM_performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    
	[self performSelector:@selector(MCSM_performBlock:) 
			   withObject:[block copy]
               afterDelay:delay];
}

@end
