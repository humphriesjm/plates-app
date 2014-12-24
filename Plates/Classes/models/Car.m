//
//  Car.m
//  Plates
//
//  Created by Jason Humphries on 12/23/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "Car.h"

@implementation Car

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"createdAt" : @"created_at",
             @"userID" : @"user_id"
             };
}

// syntax for JSONTransformer is <key>JSONTransformer
// serialize a property with forwardBlock and deserialize with reverseBlock
+ (NSValueTransformer*)createdAtJSONTransformer
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:
            ^(NSString *dateStr) {
                return [dateFormatter dateFromString:dateStr];
            } reverseBlock:
            ^(NSDate *date) {
                return [dateFormatter stringFromDate:date];
            }];
}

@end
