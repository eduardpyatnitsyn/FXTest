//
//  EPMessage.m
//  ForexClubTest
//
//  Created by Эдуард Пятницын on 26.02.16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "EPMessage.h"

@implementation EPMessage

-(NSDictionary *)mappingRules{
    return @{@"Id": @"messageId",
             @"Text": @"messageText"};
}

@end
