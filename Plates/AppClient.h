//
//  AppClient.h
//  APIHook
//
//  Created by Jason Humphries on 4/5/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "AFHTTPSessionManager.h"

// set your base api url
#define API_BASE_URL @"https://plates-rails.herokuapp.com"

@class Car;

@interface AppClient : AFHTTPSessionManager

+ (id)sharedClient;

-(void)getCars:(void (^)(NSArray*))success
       failure:(void (^)(NSError *error))failure;

- (void)postCar:(Car*)car
        success:(void (^)(Car*))successCar
        failure:(void (^)(NSError *error))failure;

@end
