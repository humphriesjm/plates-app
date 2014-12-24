//
//  AppClient.m
//  APIHook
//
//  Created by Jason Humphries on 4/5/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "AppClient.h"
#import "Car.h"

static AppClient *sharedClient;

@implementation AppClient

- (id)init
{
    if (self = [super init]) {
        NSURL *baseURL = [NSURL URLWithString:API_BASE_URL];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSDictionary *headers = @{ @"Accept"       : @"application/json",
                                   @"Content-Type" : @"application/json" };
        [config setHTTPAdditionalHeaders:headers];
        self = [[AppClient alloc] initWithBaseURL:baseURL
                             sessionConfiguration:config];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    return self;
}

+ (id)sharedClient
{
    if (!sharedClient) {
        sharedClient = [[self alloc] init];
    }
    return sharedClient;
}

#pragma mark - GET STUFF FROM SERVER

- (void)getCars:(void (^)(NSArray *))success
        failure:(void (^)(NSError *))failure
{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/cars";
    AppClient *client = [AppClient sharedClient];
    [client GET:path
     parameters:nil
        success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         NSLog(@"API GET Cars SUCCESS: %@", responseObject);
//         if (success) success(responseObject);
         [self processCarObjects:responseObject
                      completion:success];
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"API GET Cars FAILED: %@", error.localizedDescription);
         if (failure) failure(error);
     }];
}

- (void)processCarObjects:(NSArray*)carArray
               completion:(void(^)(NSArray*))completion
{
    NSMutableArray *carArr = [NSMutableArray new];
    for (NSDictionary *carDict in carArray) {
        NSError *err;
        Car *newCar = [MTLJSONAdapter modelOfClass:[Car class] fromJSONDictionary:carDict error:&err];
        [carArr addObject:newCar];
    }
    if (completion) completion(carArr);
}

#pragma mark - POST STUFF TO SERVER

- (void)postCar:(Car *)car
        success:(void (^)(Car *))successCar
        failure:(void (^)(NSError *))failure
{
    NSDictionary *carDict = [MTLJSONAdapter JSONDictionaryFromModel:car];
    
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/cars";
    NSDictionary *params = carDict;
    AppClient *client = [AppClient sharedClient];
    [client POST:path
      parameters:params
         success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         NSLog(@"API POST SUCCESS: %@", responseObject);
         
         Car *returnedCar = [MTLJSONAdapter modelOfClass:[Car class]
                                      fromJSONDictionary:responseObject error:nil];
         
         if (successCar) successCar(returnedCar);
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"API POST FAILED: %@", error.localizedDescription);
         if (failure) failure(error);
     }];
}


@end
