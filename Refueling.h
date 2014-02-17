//
//  Refueling.h
//  iCars
//
//  Created by Emilian Parvanov on 2/12/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Car;

@interface Refueling : NSManagedObject

@property (nonatomic, retain) NSDate * refuelingDate;
@property (nonatomic, retain) NSNumber * fuelPrice;
@property (nonatomic, retain) NSString * fuelType;
@property (nonatomic, retain) NSNumber * fullTank;
@property (nonatomic, retain) NSString * refuelingGasStation;
@property (nonatomic, retain) NSNumber * refuelingQantity;
@property (nonatomic, retain) NSNumber * refuelingTotalCost;
@property (nonatomic, retain) NSNumber * odometer;
@property (nonatomic, retain) Car *car;

@end
