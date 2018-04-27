//
//  EPApiManager+MessageRequest.h
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPApiManager.h"
#import "EPMessage.h"
#import "EPMessageInfo.h"

@interface EPApiManager (MessageRequest)

-(void) getMessages:(void (^)(NSArray <EPMessage *> *messages, EPMessageInfo *messageInfo)) success
            failure:(void (^)(NSError *error))failure;

@end
