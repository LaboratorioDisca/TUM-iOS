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
    enum Category { STOP, FACULTY, LIBRARY, STORE };
    NSString *name;
    CLLocationCoordinate2D coordinate;
    enum Category *category;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) enum Category *category;


- (id) initWithName:(NSString*)name andCoordinate:(CLLocationCoordinate2D)coordinate;

- (NSString*) placeCategory;

@end
