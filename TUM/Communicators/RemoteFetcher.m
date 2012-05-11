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
#import "Vehicles.h"
#import "Instants.h"

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

+ (void) reloadInstants
{
    [RemoteFetcher performFetchForResource:@"instants"];
}

+ (void) loadVehicles
{
    [RemoteFetcher performFetchForResource:@"vehicles"];
}

+ (void) performFetchForResource:(NSString*) resource
{    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"routes.plist"];
    NSDictionary *routes = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    NSString *stringURL = [[NSString stringWithString:[routes objectForKey:@"url"]] 
                              stringByAppendingString:[routes objectForKey:resource]];
    
    __block ASIHTTPRequest *_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:stringURL]];
    __weak ASIHTTPRequest *request = _request;
    
    [request setCompletionBlock:^{
        // Use when fetching text data
        if(resource==@"routes") {
            [Routes loadWithRoutesCollection:[[request responseString] JSONValue]];
        } else if(resource==@"vehicles") {
            [Vehicles loadWithVehiclesCollection:[[request responseString] JSONValue]];
        } else if(resource==@"instants") {
            [Instants loadWithInstantsCollection:[[request responseString] JSONValue]];
        }
    }];
    [request setFailedBlock:nil];
    [request startAsynchronous];

}


@end
