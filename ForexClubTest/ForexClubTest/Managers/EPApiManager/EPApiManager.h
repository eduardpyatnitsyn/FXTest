//
//  EPApiManager.h
//  ForexClubTestApp
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit.h>

@class EPModel;

@interface EPApiManager : NSObject

- (void)configureResponseDescriptor:(EPModel *)mappingClass
                             method:(RKRequestMethod) method
                               path:(NSString *) path
                            keypath:(NSString *) keypath;

- (void)getObjectsAtPath:(NSString *)path
              parameters:(NSDictionary *)params
                 success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end
