//
//  EPApiManager+MessageRequest.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPApiManager+MessageRequest.h"
#import "EPMessage.h"
#import "EPMessageInfo.h"

@implementation EPApiManager (MessageRequest)

-(void) getMessages:(void (^)(NSArray <EPMessage *> *messages, EPMessageInfo *messageInfo)) success
            failure:(void (^)(NSError *error))failure{
    [self setupMessageModels];
    [self getObjectsAtPath:@"/Backend/Dicts/IOS/messages/ru_RU/data"
                parameters:nil
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                       success([mappingResult.dictionary valueForKey:@"Data"],
                               [mappingResult.dictionary valueForKey:@"Info"]);
                   }failure:^(RKObjectRequestOperation *operation, NSError *error) {
                        failure(error);
                   }];
}

-(void) setupMessageModels{
    [self configureResponseDescriptor:[EPMessage new]
                               method:RKRequestMethodGET
                                 path:nil
                              keypath:@"Data"];
    [self configureResponseDescriptor:[EPMessageInfo new]
                               method:RKRequestMethodGET
                                 path:nil
                              keypath:@"Info"];
}

@end
