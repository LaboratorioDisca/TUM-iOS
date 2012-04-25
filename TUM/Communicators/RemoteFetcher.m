//
//  RemoteFetcher.m
//  TUM
//
//  Created by Alejandro on 25/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "RemoteFetcher.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"
#import "Routes.h"

@interface RemoteFetcher() {
    
}

+ (void) performFetchForResource:(NSString*)resource;

@end

@implementation RemoteFetcher
@synthesize responseData;

+ (void) loadRoutes
{
    [RemoteFetcher performFetchForResource:@"routes"];
}

+ (void) loadInstants
{
    
}

+ (void) loadVehicles
{
    
}

+ (void) performFetchForResource:(NSString*) resource
{    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"routes.plist"];
    NSDictionary *routes = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    NSString *stringURL = [[NSString stringWithString:[routes objectForKey:@"url"]] 
                              stringByAppendingString:[routes objectForKey:resource]];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:stringURL]];
    [request setCompletionBlock:^{
        // Use when fetching text data
        if(resource==@"routes") {
            [Routes setCollection:[[request responseString] JSONValue]];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
    }];
    [request startAsynchronous];

}


@end
