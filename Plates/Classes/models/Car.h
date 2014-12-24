//
//  Car.h
//  Plates
//
//  Created by Jason Humphries on 12/23/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MTLModel.h"

@interface Car : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readwrite) NSString *plate;
@property (nonatomic, strong, readwrite) NSString *color;
@property (nonatomic, strong, readwrite) NSString *make;
@property (nonatomic, strong, readwrite) NSString *model;
@property (nonatomic, strong, readwrite) NSString *userID;
@property (nonatomic, strong, readwrite) NSDate *createdAt;
@end
