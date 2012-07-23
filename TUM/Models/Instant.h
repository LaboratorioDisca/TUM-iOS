//
//  Instant.h
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Instant : NSObject {
    NSDate *date;
    NSNumber *vehicleId;
    NSNumber *vehicleSpeed;
    CLLocationCoordinate2D coordinates;
}

@property (strong, atomic) NSDate *date;
@property (strong, atomic) NSNumber *vehicleId;
@property (strong, atomic) NSNumber *vehicleSpeed;
@property CLLocationCoordinate2D coordinates;

- (id) initWithCoordinates:(NSDictionary*)coordinates 
             withVehicleId:(NSNumber*)vehicleId_ 
          withVehicleSpeed:(NSNumber*)speed_ 
          withMilliseconds:(double) milliseconds;


@end
