//
//  Vehicle.h
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject {
    NSString *number;
    NSNumber *identifier;
    NSNumber *lineId;
    NSString *vehicleNumber;
}

@property (strong, atomic) NSString *number;
@property (strong, atomic) NSNumber *identifier;
@property (strong, atomic) NSNumber *lineId;
@property (strong, atomic) NSString *vehicleNumber;

- (id) initWithNumber:(NSString*)number withIdentifier:(NSNumber*)identifier withLineId:(NSNumber*)lineId withVehicleNumber:(NSString*)vehicleNumber;

@end
