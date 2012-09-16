//
//  Station.h
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Place : NSObject {
    NSString *name;
    CLLocationCoordinate2D coordinate;
    NSNumber* category;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSNumber* category;


- (id) initWithName:(NSString*)name andCoordinate:(CLLocationCoordinate2D)coordinate andCategory:(NSNumber*)placeCategory;

- (NSString*) placeCategory;

@end
