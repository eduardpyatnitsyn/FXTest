//
//  EPApiManager.m
//  ForexClubTestApp
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPApiManager.h"
#import "EPModel.h"
#import "Constants.h"

@implementation EPApiManager{
    AFHTTPClient *client;
    RKObjectManager *objectManager;
}

-(instancetype)init{
    if (self = [super init]){
        client = [[AFHTTPClient alloc] initWithBaseURL:cApiServerUrl];
        objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    }
    return self;
}

- (void)configureResponseDescriptor:(EPModel *)mappingClass
                             method:(RKRequestMethod) method
                               path:(NSString *) path
                            keypath:(NSString *) keypath{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[mappingClass class]];
    [objectMapping addAttributeMappingsFromDictionary:[mappingClass mappingRules]];
    
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
                                                 method:method
                                            pathPattern:path
                                                keyPath:keypath
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)getObjectsAtPath:(NSString *)path
                    parameters:(NSDictionary *)params
                       success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
    [objectManager getObjectsAtPath:[NSString stringWithFormat:@"%@%@", [cApiServerUrl absoluteString], path]
                         parameters:params
                            success:success
                            failure:failure];
}

-(NSIndexSet *) acceptableStatusCodes{
    return [NSIndexSet indexSetWithIndex:200];
}

@end
